return {
  "numToStr/Comment.nvim",
  config = function()
    require('Comment').setup()
  end,
  keys = {
    { "<leader>cc", mode = { "n", "v" }, "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", desc = "Comment lines" },
    { "<leader>cu", mode = { "n", "v" }, "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", desc = "Uncomment lines" },
  },
}
