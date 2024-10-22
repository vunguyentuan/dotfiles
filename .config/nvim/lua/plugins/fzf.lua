return {
  'ibhagwan/fzf-lua',
  -- enabled = false,
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
      -- grep = {
      --   -- multiline = 2,
      -- },
      files = {
        prompt = ' ❯ ',
        git_icons = true,
        file_icons = true,

        -- cwd_prompt = false,
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

  end,
}
