require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "rust", "vim", "html" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
  fold = {
    enable = true,
  }
}
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

