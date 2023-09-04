return {
  -- Copilot
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    enabled = false,
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        suggestion = { enabled = false },
        panel = { enabled = false },

      })
    end
  },
  {
    'zbirenbaum/copilot-cmp',
    event = "VeryLazy",
    enabled = false,
    dependencies = { 'zbirenbaum/copilot.lua' },
    config = function()
      require("copilot_cmp").setup()
    end
  },
}
