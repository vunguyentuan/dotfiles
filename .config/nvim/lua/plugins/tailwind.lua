return {
  'luckasRanarison/tailwind-tools.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  opts = {}, -- your configuration
}

-- return {

--   'roobert/tailwindcss-colorizer-cmp.nvim',
--   ft = {
--     'typescriptreact',
--     'javascriptreact',
--     'html'
--   },
--   -- enabled = false,
--   -- optionally, override the default options:
--   config = function()
--     require('tailwindcss-colorizer-cmp').setup {
--       color_square_width = 2,
--     }

--     require('cmp').config.formatting = {
--       format = require('tailwindcss-colorizer-cmp').formatter,
--     }
--   end,
-- }
