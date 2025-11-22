return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
		{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	},
	event = "VeryLazy",
	config = function()
		vim.o.foldcolumn = "1" -- shows fold icons on the left
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
		vim.o.fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:▶]]

		require("ufo").setup({
			provider_selector = function()
				return { "treesitter", "indent" } -- treesitter first, indent as fallback
			end,
		})
	end,
}
