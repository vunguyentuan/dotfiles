return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    {
      '<leader>hh',
      function()
        require('harpoon.ui').toggle_quick_menu()
      end,
      desc = '[H]arpoon [H]ome',
    },
    {
      '<leader>ha',
      function()
        require('harpoon.mark').add_file()
      end,
      desc = '[H]arpoon Add',
    },
    {
      '<leader>jj',
      function()
        require('harpoon.ui').nav_file(1)
      end,
      desc = '[H]arpoon to file 1',
    },
    {
      '<leader>kk',
      function()
        require('harpoon.ui').nav_file(2)
      end,
      desc = '[H]arpoon to file 2',
    },

    {
      '<leader>ll',
      function()
        require('harpoon.ui').nav_file(3)
      end,
      desc = '[H]arpoon to file 3',
    },

    {
      '<leader>;;',
      function()
        require('harpoon.ui').nav_file(4)
      end,
      desc = '[H]arpoon to file 4',
    },
  },
  config = function()
    require('harpoon').setup {}

    -- require("telescope").load_extension('harpoon')
  end,
}
