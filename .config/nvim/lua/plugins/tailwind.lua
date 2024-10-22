return {
  'luckasRanarison/tailwind-tools.nvim',
  event = "LspAttach",
  name = "tailwind-tools",
  build = ":UpdateRemotePlugins",
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = {}, -- your configuration
}
