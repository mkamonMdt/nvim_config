return {
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  {
    'rust-lang/rust.vim',
    ft = "rust",
    config = function()
      vim.g.rustfmt_autosave = 1
    end
  }
}
