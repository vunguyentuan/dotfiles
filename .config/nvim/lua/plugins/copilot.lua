return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'VeryLazy',
  dependencies = {
    {
      'zbirenbaum/copilot-cmp',
      config = function()
        require('copilot_cmp').setup()
      end,
    },
  },
  config = function()
    require('copilot').setup {
      panel = {
        enabled = false,
        auto_refresh = true,
        keymap = {
          jump_prev = '[[',
          jump_next = ']]',
          accept = '<CR>',
          refresh = 'gr',
          open = '<M-CR>',
        },
        layout = {
          position = 'right',   -- | top | left | right
          ratio = 0.4,
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = false,
        debounce = 3000,
        keymap = {
          accept = '<M-l>',
          accept_word = false,
          accept_line = false,
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ['.'] = false,
      },
      copilot_node_command = 'node',   -- Node.js version must be > 18.x
      server_opts_overrides = {},
    }
  end,
}
