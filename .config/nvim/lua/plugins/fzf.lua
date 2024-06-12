-- Fuzzy Finder Algorithm which requires local dependencies to be built.
-- Only load if `make` is available. Make sure you have the system
-- requirements installed.

return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = 'FzfLua',
  keys = {
    -- { '<leader><space>', '<cmd>GrugFar<CR>', desc = 'Find and replace' },
    { '<leader>f', '<cmd>FzfLua files<cr>', desc = 'File files' },
    { '<leader>ss', '<cmd>FzfLua live_grep<cr>', desc = 'Live grep' },
    { '<leader>gg', '<cmd>FzfLua git_status<cr>', desc = 'Git status' },
  },
  config = function()
    require('fzf-lua').setup {
      grep = {
        multiline = 2,
      },
      files = {
        prompt = ' ❯ ',
        git_icons = true,
        file_icons = true,

        cwd_prompt = false,
        -- formatter = 'path.filename_first',
      },
      winopts = {
        preview = {
          hidden = 'hidden',
        },
      },

      keymap = {
        fzf = {
          ['ctrl-q'] = 'select-all+accept',
        },
      },
    }

    -- calling `setup` is optional for customization
    -- require('fzf-lua').setup {
    --   -- 'telescope',
    --   -- 'max-perf',
    --   -- 'fzf-native',
    --   -- 'default',
    --   -- fullscreen = true,
    --   keymap = {
    --     fzf = {
    --       ['ctrl-q'] = 'select-all+accept',
    --     },
    --   },
    -- }
  end,
}
