return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
  },
  {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
        local lga_actions = require("telescope-live-grep-args.actions")
        local last_query = ""
		require("telescope").setup({
		    defaults = {
			file_ignore_patterns = { "node%_modules/.*" },
			layout_strategy = "vertical",  -- Set layout to vertical
			-- Default configurations for all pickers
			layout_config = {
			-- Set the width and height to 80% of the screen
			    width = 0.9,
			    height = 0.9,
			    preview_cutoff = 40,  -- Show preview only for files bigger than 40 columns
			    prompt_position = "bottom",  -- Prompt at the top of the window
			    mirror = false,  -- Preview on the top, results below (false = preview on top)
			},
		    },
		    pickers = {
			-- Configuration specific to live_grep_args or other pickers
			live_grep_args = {
			    layout_strategy = "vertical",  -- Apply vertical layout for live_grep_args picker
			    layout_config = {
				width = 0.9,  -- 80% of the screen width
				height = 0.9, -- 80% of the screen height
				preview_cutoff = 40,
				prompt_position = "bottom",
				mirror = false,
			    },
			},
		    },
		    extensions = {
		      live_grep_args = {
                auto_quoting = true, -- enable/disable auto-quoting
                -- define mappings, e.g.
                mappings = { -- extend mappings
                    i = {
                    ['<C-k>'] = function(prompt_bufnr)
                        last_query = require('telescope.actions.state').get_current_line(prompt_bufnr)
                        require('telescope-live-grep-args.actions').quote_prompt()(prompt_bufnr)
                    end,
                    ['<C-i>'] = function(prompt_bufnr)
                        last_query = require('telescope.actions.state').get_current_line(prompt_bufnr)
                        require('telescope-live-grep-args.actions').quote_prompt({ postfix = " --iglob " })(prompt_bufnr)
                    end,
                    -- freeze the current list and start a fuzzy search in the frozen list
                    ['<c-space>'] = lga_actions.to_fuzzy_refine,
                    },
                },
                theme = {
                    dropdown = {
                    layout_strategy = "vertical",
                    layout_config = {
                        width = 0.9,
                        height = 0.9,
                        preview_cutoff = 40,
                        prompt_position = "bottom",
                        mirror = false,
                    },
                    },
                },
                }
		    }
		})
		require("telescope").load_extension("live_grep_args")
		require("telescope").load_extension("ui-select")
		local builtin = require('telescope.builtin')

		vim.keymap.set('n', '<c-p>', builtin.find_files, {})
		vim.keymap.set('n', '<Space><Space>', builtin.oldfiles, {})
		vim.keymap.set('n', '<Space>gi', builtin.lsp_references, {})
		vim.keymap.set('n', '<Space>fh', builtin.help_tags, {})
		vim.keymap.set('n', "<leader>fg", function()
            require('telescope').extensions.live_grep_args.live_grep_args({
                default_text = last_query})
        end, {})
	end
  }
}


