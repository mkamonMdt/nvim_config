vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

-- use spaces for tabs and whatnot 
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.cmd [[ set noswapfile ]]
vim.cmd [[ set termguicolors ]]

--Line numbers
vim.wo.relativenumber = true
vim.wo.number = true

--Keymaps
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')


-- Define highlight groups for Red, Green, Blue
vim.cmd('highlight PhraseR ctermfg=Red guifg=Red')
vim.cmd('highlight PhraseG ctermfg=Green guifg=Green')
vim.cmd('highlight PhraseB ctermfg=Blue guifg=#1E90FF')
vim.cmd('highlight PhraseBackGroundR ctermbg=Red guibg=#8B0000')
vim.cmd('highlight PhraseBackGroundG ctermbg=Green guibg=#006400')
vim.cmd('highlight PhraseBackGroundB ctermbg=Blue guibg=Blue')

-- Create a custom command that highlights multiple phrases with a given color
vim.api.nvim_create_user_command('HighlightPhrases', function(opts)
  local color = opts.fargs[1]  -- Color ('R', 'G', 'B')
  local phrases = {}           -- List to hold all phrases
  
  -- Collect all phrases passed as arguments
  for i = 2, #opts.fargs do
    table.insert(phrases, opts.fargs[i])
  end
  
  -- Determine the highlight group based on color
  local highlight_group = ''
  if color == 'R' then
    highlight_group = 'PhraseR'
  elseif color == 'G' then
    highlight_group = 'PhraseG'
  elseif color == 'B' then
    highlight_group = 'PhraseB'
  elseif color == 'backR' then
    highlight_group = 'PhraseBackGroundR'
  elseif color == 'backG' then
    highlight_group = 'PhraseBackGroundG'
  elseif color == 'backB' then
    highlight_group = 'PhraseBackGroundB'
  else
    print('Invalid color. Use R, G, or B.')
    return
  end

  -- Highlight each phrase with the corresponding color
  for _, phrase in ipairs(phrases) do
    vim.fn.matchadd(highlight_group, phrase)
  end
end, {nargs = '+'})  -- Expect at least 1 argument (color) and one or more phrases

-- command to remove all highlights
vim.api.nvim_create_user_command('RemoveAllHighlights', function()
  -- Loop through all match IDs and delete them
  for _, match_id in ipairs(vim.fn.getmatches()) do
    vim.fn.matchdelete(match_id.id)
  end
end, {})

