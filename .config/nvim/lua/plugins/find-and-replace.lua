return {
  'MagicDuck/grug-far.nvim',
  keys = {
    {
      '<leader>/',
      '<cmd>GrugFar<CR>',
      desc = 'Find and Replace',
    },
  },
  config = function()
    require('grug-far').setup {}
  end,
}
