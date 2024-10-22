return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  enabled = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  keys = {
    {
      '<leader>f',
      function()
        require('telescope.builtin').find_files({ previewer = false })
      end,
      desc = 'Find files',
    },
    {
      '<leader>ss',
      function()
        require('telescope.builtin').live_grep()
      end,
      desc = 'Find files',
    },
  },

  config = function()
    require("telescope").setup({
      defaults =  require('telescope.themes').get_dropdown {
        preview = {
          enable = false,
        },
        mappings = {
          i = {
            ["<C-g>"] = require("telescope.actions").to_fuzzy_refine,
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },
    })

    require('telescope').load_extension('fzf')
  end
}
