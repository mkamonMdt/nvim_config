-- lua/plugins/conform.lua
return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua     = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css     = { "prettier" },
        html    = { "prettier" },
        json    = { "prettier" },
        yaml    = { "prettier" },
        markdown = { "prettier" },
        eruby   = { "erb-format" },  -- or just prettier if you don’t need erb-specific
        ruby    = { "rubocop" },     -- rubocop can format with --auto-correct
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })
  end,
}
