return {
  'mg979/vim-visual-multi',
  event = 'VeryLazy',
  enabled = false,
  init = function()
    vim.g.VM_maps = {}
    vim.g.VM_maps = {
      ['Find Under'] = '<C-m>',
    }
  end,
  -- keys = {
  --   {
  --     mode = { 'v', 'n' },
  --     '<Leader>m',
  --     '<cmd>MCstart<cr>',
  --     desc = 'Create a selection for selected text or word under the cursor',
  --   },
  -- },
}
