return {
  {
    'nvim-tree/nvim-tree.lua',
    keys = {
      {
        '<C>n',
        '<cmd>:NvimTreeToggle<CR>',
        desc = 'Toggle Tree',
      },
    },
    config = function()
      require('nvim-tree').setup {
        sort = {
          sorter = 'case_sensitive',
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      }
    end,
    enabled = false,
  },
  -- {
  --   'antosha417/nvim-lsp-file-operations',
  --   enabled = false,
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-tree/nvim-tree.lua',
  --   },
  --   config = function()
  --     require('lsp-file-operations').setup()
  --   end,
  -- },
}
