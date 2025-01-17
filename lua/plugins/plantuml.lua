return {
  'https://gitlab.com/itaranto/plantuml.nvim',
  version = '*',
  config = function()
    require('plantuml').setup({
        renderer = {
            type = 'image',
            options = {
                split_cmd = 'vsplit', -- Allowed values: 'split', 'vsplit'.
                prog = 'feh',
                dark_mode = true,
                format = 'png', -- Allowed values: nil, 'png', 'svg'.
            }
        },
        render_on_write = true,
    })
  end,
}

