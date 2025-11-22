return {
	"williamboman/mason.nvim",
	dependencies = {
		--		"rshkarin/mason-lint.nvim", -- for linters
		"zapling/mason-conform.nvim",
	},
	config = function()
		require("mason").setup()
		--		require("mason-nvim-lint").setup() -- auto-installs the formatters above
	end,
}
