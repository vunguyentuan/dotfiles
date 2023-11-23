local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.opt.listchars = { extends = '.', precedes = '|', nbsp = '_', tab = '???' }
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.relativenumber = true

keymap('n', '<leader>f', '<cmd>lua MiniPick.builtin.files()<cr>', { noremap = true, silent = true, desc = 'Find File' })
keymap('n', '<leader>fm', '<cmd>lua MiniFiles.open()<cr>', { noremap = true, silent = true, desc = 'Find Manualy' })
keymap('n', '<leader><space>', '<cmd>lua MiniPick.builtin.buffers()<cr>', { noremap = true, silent = true, desc = 'Find Buffer' })
keymap('n', '<leader>fs', '<cmd>lua MiniPick.builtin.grep_live()<cr>', { noremap = true, silent = true, desc = 'Find String' })

keymap('n', '<leader>ss', '<cmd>lua MiniSessions.select()<cr>', { noremap = true, silent = true, desc = 'Switch Session' })

keymap('n', '<leader>bd', '<cmd>bd<cr>', { noremap = true, silent = true, desc = 'Close Buffer' })

vim.filetype.add {
  filename = {
    ['inventory'] = 'dosini',
  },
}

require('lazy').setup {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.statusline').setup {
        user_icons = true,
      }
      require('mini.basics').setup {
        options = {
          extra_ui = true,
          win_borders = 'double',
        },
        mappings = {
          windows = true,
        },
      }
      require('mini.base16').setup {
        palette = {
          base00 = '#1d2021',
          base01 = '#3c3836',
          base02 = '#504945',
          base03 = '#665c54',
          base04 = '#bdae93',
          base05 = '#d5c4a1',
          base06 = '#ebdbb2',
          base07 = '#fbf1c7',
          base08 = '#fb4934',
          base09 = '#fe8019',
          base0A = '#fabd2f',
          base0B = '#b8bb26',
          base0C = '#8ec07c',
          base0D = '#83a598',
          base0E = '#d3869b',
          base0F = '#d65d0e',
        },
      }
      require('mini.comment').setup()
      require('mini.completion').setup()
      require('mini.files').setup()
      require('mini.move').setup()
      require('mini.indentscope').setup {
        draw = {
          animation = function(s, n)
            return 5
          end,
        },
        symbol = '|',
      }
      require('mini.pairs').setup()
      require('mini.pick').setup {
        options = {
          use_cache = true,
        },
      }
      require('mini.sessions').setup {
        autowrite = true,
      }
      require('mini.starter').setup {
        header = '███╗   ███╗██╗   ██╗██╗███╗   ███╗\n████╗ ████║██║   ██║██║████╗ ████║\n██╔████╔██║██║   ██║██║██╔████╔██║\n██║╚██╔╝██║╚██╗ ██╔╝██║██║╚██╔╝██║\n██║ ╚═╝ ██║ ╚████╔╝ ██║██║ ╚═╝ ██║\n╚═╝     ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝\n                                  ',
      }
      require('mini.surround').setup()
      require('mini.tabline').setup()
    end,
  },
}
