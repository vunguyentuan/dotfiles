return {
  'supermaven-inc/supermaven-nvim',
  event = "VeryLazy",
  enabled = false,
  opts = {
    -- keymaps = {
    --   accept_suggestion = '<CR>',
    --   clear_suggestion = '<C-c>',
    --   accept_word = '<C-j>',
    -- },
    ignore_filetypes = {},
    color = {
      suggestion_color = '#ffffff',
      cterm = 244,
    },
    log_level = 'off',
    -- disable_inline_completion = true, -- disables inline completion for use with cmp
    -- disable_keymaps = true,           -- disables built in keymaps for more manual control
  },
}
