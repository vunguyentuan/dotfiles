return {
  "folke/zen-mode.nvim",
  keys = {
    {
      "<leader>z",
      function()
        require("zen-mode").toggle()
      end,
      desc = "Zen Mode",
    },
  },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
}
