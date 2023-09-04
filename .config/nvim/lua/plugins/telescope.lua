-- Fuzzy Finder (files, lsp, etc)
return {
  'nvim-telescope/telescope.nvim',

  cmd = "Telescope",
  enabled = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      lazy = true,
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    }
  },
  keys = {
    { "<leader><space>", "<cmd>Telescope buffers<cr>",                   desc = "Switch Buffer" },
    { "<leader>f",       "<cmd>Telescope find_files hidden=true<cr>",    desc = "File files" },
    { "<leader>ss",      "<cmd>Telescope live_grep<cr>",                 desc = "Live grep" },
    { "<leader>sb",      "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Symbol find" },
  },
  config = function()
    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },

      file_ignore_patterns = {
        "node_mododules",
        "^.git/",
        "build",
        "dist",
        "out",
        ".next"
      },

      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    }

    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')
  end
}
