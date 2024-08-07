return {
  'mrjones2014/smart-splits.nvim',
  config = function()
    require('smart-splits').setup()
    vim.keymap.set('n', '<D-C-h>', require('smart-splits').resize_left)
    vim.keymap.set('n', '<D-C-j>', require('smart-splits').resize_down)
    vim.keymap.set('n', '<D-C-k>', require('smart-splits').resize_up)
    vim.keymap.set('n', '<D-C-l>', require('smart-splits').resize_right)

    -- moving between splits
    vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
    vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
    vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
    vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
    vim.keymap.set('n', '<C-[>', require('smart-splits').move_cursor_previous)
  end,
}
