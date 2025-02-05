local file_labels = {
  bindings = "/home/mk/.config/nvim/doc/key_bindings.md",
  -- Add more labels and paths as needed
}

local function open_float_notes(file_path)
  -- Create a new buffer for your notes
  local buf = vim.api.nvim_create_buf(false, true)

  -- Read the contents of the Markdown file
  local lines = {}
  local file = io.open(file_path, "r")
  if file then
    for line in file:lines() do
      table.insert(lines, line)
    end
    file:close()
  else
    -- If the file can't be opened, set an error message
    table.insert(lines, "Error: Could not open file at " .. file_path)
  end

  -- Set the buffer content with the lines from the file
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  -- Open the buffer in a floating window with full width and half height
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = vim.o.columns,
    height = math.floor(vim.o.lines / 2),
    col = 0,  -- Start at the left edge of the screen
    row = math.floor(vim.o.lines / 4),  -- Center vertically if possible
    style = "minimal",
    border = "rounded",
  })
end

local function list_labels()
  local buf = vim.api.nvim_create_buf(false, true)
  local lines = { "Available Notes:" }
  for label in pairs(file_labels) do
    table.insert(lines, "  - " .. label)
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = math.floor(vim.o.columns / 2),
    height = #lines + 2, -- Add space for border
    col = math.floor(vim.o.columns / 4),
    row = math.floor(vim.o.lines / 4),
    style = "minimal",
    border = "rounded",
  })
end

-- Create the user command with an argument
vim.api.nvim_create_user_command('MyNote', function(opts)
  local label = opts.args

  if label == "" then
    list_labels()
  elseif file_labels[label] then
    open_float_notes(file_labels[label])
  else
    vim.api.nvim_err_writeln("Error: No file associated with label '" .. label .. "'")
  end
end, {
  nargs = "?",
  desc = "Open floating window with notes or list available labels",
})

return {}
