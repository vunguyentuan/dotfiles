return {
  {
    'RaafatTurki/corn.nvim',
    enabled = false,
    config = function()
      require('corn').setup()
    end,
  },
  -- Lazy
  {
    'dgagn/diagflow.nvim',
    event = 'LspAttach',
    opts = {},
  },
}
