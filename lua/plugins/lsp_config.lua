return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.ts_ls.setup({
        capabilities = capabilities
      })
      lspconfig.solargraph.setup({
        capabilities = capabilities
      })
      lspconfig.html.setup({
        capabilities = capabilities
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })


    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
    vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, {})  -- Alternative to 'gd'
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, {})

    -- Navigation back (these are Vim native, so they work regardless of LSP)
    vim.keymap.set('n', '<C-o>', '<C-o>', {})  -- Go back to the previous location
    vim.keymap.set('n', '<C-i>', '<C-i>', {})  -- Go forward to the next location

    -- action 
    vim.keymap.set("n", "<Leader>a", function()
        vim.lsp.buf.code_action({
            border = "rounded", -- Optional: Rounded border for aesthetics
            max_width = math.floor(vim.o.columns * 0.5), -- Half the width of the screen
            max_height = math.floor(vim.o.lines * 0.3), -- 30% of the total screen height
        })
        end, { noremap = true, silent = true, desc = "LSP Code Action" })
    end,
  },
}

