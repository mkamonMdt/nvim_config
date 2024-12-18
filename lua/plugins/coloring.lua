-- Define highlight groups for Red, Green, Blue
vim.cmd('highlight PhraseR ctermfg=Red guifg=Red')
vim.cmd('highlight PhraseG ctermfg=Green guifg=Green')
vim.cmd('highlight PhraseB ctermfg=Blue guifg=#1E90FF')
vim.cmd('highlight PhraseBackGroundR ctermbg=Red guibg=#8B0000')
vim.cmd('highlight PhraseBackGroundG ctermbg=Green guibg=#006400')
vim.cmd('highlight PhraseBackGroundB ctermbg=Blue guibg=Blue')

-- Table to store match IDs
local match_ids = {
  R = {},
  G = {},
  B = {},
  backR = {},
  backG = {},
  backB = {}
}

-- Create a custom command that highlights multiple phrases with a given color
vim.api.nvim_create_user_command('Highlight', function(opts)
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

-- Highlight each phrase and store match IDs
  for _, phrase in ipairs(phrases) do
    local match_id = vim.fn.matchadd(highlight_group, phrase)
    table.insert(match_ids[color], match_id)
  end
end, {nargs = '+'})  -- Expect at least 1 argument (color) and one or more phrases

-- command to remove all highlights
vim.api.nvim_create_user_command('HighlightRemoveAll', function()
  -- Loop through all match IDs and delete them
  for _, match_id in ipairs(vim.fn.getmatches()) do
    vim.fn.matchdelete(match_id.id)
  end
end, {})

-- Command to remove all highlights of a specific color
vim.api.nvim_create_user_command('HighlightRemove', function(opts)
  local color = opts.fargs[1]  -- Color ('R', 'G', 'B')

  if color == 'R' or color == 'G' or color == 'B' or color == 'backR' or color == 'backG' or color == 'backB' then
    -- Remove all matches for the given color
    for _, match_id in ipairs(match_ids[color]) do
      vim.fn.matchdelete(match_id)
    end
    -- Clear the table for the color
    match_ids[color] = {}
  else
    print('Invalid color. Use R, G, or B.')
  end
end, {nargs = 1})  -- Expect 1 argument (color)

return {}
