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
}
