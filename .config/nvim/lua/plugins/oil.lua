return {
  'stevearc/oil.nvim',
  enabled = false,
  opts = {},
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    {
      '<C-n>',
      mode = { 'n' },
      function()
        require('oil').open()
      end,
      desc = 'Open file explorer',
    },
  },
  config = function()
    require('oil').setup {
      -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
      -- Set to false if you still want to use netrw.
      default_file_explorer = true,
      keymaps = {
        ['?'] = 'actions.show_help',
        ['<CR>'] = 'actions.select',
        ['<C-l>'] = 'actions.select',
        -- ['<C-s>'] = 'actions.select_vsplit',
        -- ['<C-h>'] = 'actions.select_split',
        -- ['<C-t>'] = 'actions.select_tab',
        ['<C-p>'] = 'actions.preview',
        ['q'] = 'actions.close',
        ['<ESC>'] = 'actions.close',
        ['<C-r>'] = 'actions.refresh',
        ['<C-h>'] = 'actions.parent',
        ['_'] = 'actions.open_cwd',
        ['`'] = 'actions.cd',
        ['~'] = 'actions.tcd',
        ['gs'] = 'actions.change_sort',
        ['gx'] = 'actions.open_external',
        ['g.'] = 'actions.toggle_hidden',
        ['g\\'] = 'actions.toggle_trash',
      },

      -- Set to false to disable all of the above keymaps
      use_default_keymaps = false,

      float = {
        -- Padding around the floating window
        padding = 10,
        max_width = 60,
        max_height = 0,
        border = 'rounded',
        win_options = {
          winblend = 0,
        },
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        override = function(conf)
          return conf
        end,
      },
    }
  end,
}
