local telescope = require("telescope")
local lga_actions = require('telescope-live-grep-args.actions')

telescope.setup({
    file_ignore_patterns = { "node%_modules/.*" },
    extensions = {
      live_grep_args = {
        auto_quoting = true, -- enable/disable auto-quoting
        -- define mappings, e.g.
        mappings = { -- extend mappings
            i = {
            ['<c-k>'] = lga_actions.quote_prompt(),
            ['<c-i>'] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            -- freeze the current list and start a fuzzy search in the frozen list
            ['<c-space>'] = lga_actions.to_fuzzy_refine,
            },
        },
        -- ... also accepts theme settings, for example:
        theme = "dropdown", -- use dropdown theme
        -- theme = { }, -- use own theme spec
        -- layout_config = { mirror=true }, -- mirror preview pane
        }
    }
})

telescope.load_extension("live_grep_args")
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<c-p>', builtin.find_files, {})
vim.keymap.set('n', '<Space><Space>', builtin.oldfiles, {})
--vim.keymap.set('n', '<Space>fg', builtin.live_grep, {})
vim.keymap.set('n', '<Space>fh', builtin.help_tags, {})
vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
