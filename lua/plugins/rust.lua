return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Pin to a particular version
    ft = { "rust" },
    config = function()
      -- Directly set the configuration without calling `setup()`
      vim.g.rustaceanvim = {
        server = {
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
              },
            },
          },
        },
      }
    end,
  },
  {
    'rust-lang/rust.vim',
    ft = "rust",
    config = function()
      vim.g.rustfmt_autosave = 1
    end
  }
}
