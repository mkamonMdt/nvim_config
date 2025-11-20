return {
  -- Keep your exact keybindings + cmp capabilities on top of LazyVim's defaults
  "neovim/nvim-lspconfig",
  dependencies = { "hrsh7th/cmp-nvim-lsp" },  -- ensures cmp_nvim_lsp is loaded
  init = function()
    -- Disable LazyVim's default LSP keymaps that conflict with yours (optional but clean)
    vim.g.lazyvim_lsp = vim.g.lazyvim_lsp or {}
    vim.g.lazyvim_lsp.keymaps = { silent = true }  -- keeps diagnostics etc., but no gd/K etc.
  end,
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    -- Tell all servers to use these enhanced capabilities
    require("lspconfig.util").on_setup = require("lspconfig.util").on_setup or function(config)
      config.capabilities = vim.tbl_deep_extend("force", config.capabilities or {}, capabilities)
    end

    -- Your exact keybindings (only attach when an LSP is actually active)
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc or "" })
        end

        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "<C-]>", vim.lsp.buf.definition, "Go to definition (Ctrl-])")
        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        map("n", "gr", vim.lsp.buf.references, "Find references")
        map("n", "K", vim.lsp.buf.hover, "Hover documentation")
        map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

        -- Your fancy code action
        map("n", "<leader>a", function()
          vim.lsp.buf.code_action({
            border = "rounded",
            max_width = math.floor(vim.o.columns * 0.5),
            max_height = math.floor(vim.o.lines * 0.3),
          })
        end, "LSP code actions")

        -- Navigation (these are global, not buffer-local)
        vim.keymap.set("n", "<C-o>", "<C-o>", { desc = "Jump back" })
        vim.keymap.set("n", "<C-i>", "<C-i>", { desc = "Jump forward" })
      end,
    })
  end,
}
