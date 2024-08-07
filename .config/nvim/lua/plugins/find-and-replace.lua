return {
  'MagicDuck/grug-far.nvim',
  keys = {
    {
      '<leader>/',
      '<cmd>GrugFar<CR>',
      desc = 'Find and Replace',
    },
  },
  cmd = { "GrugFar" },
  config = function()
    require('grug-far').setup {}
  end,
}
