return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'folke/noice.nvim',
  },

  -- See `:help lualine.txt`
  config = function()
    require('lualine').setup {
      options = {
        theme = 'auto',
        icons_enabled = true,
        -- globalstatus = true,
        component_separators = { left = '', right = '' },
        -- component_separators = '|',
        -- section_separators = '',
      },

      sections = {
        lualine_b = { 'branch', 'diagnostics' },
        -- lualine_x = {
        --   {
        --     require("noice").api.statusline.mode.get,
        --     cond = require("noice").api.statusline.mode.has,
        --     color = { fg = "#ff9e64" },
        --   }
        -- },
        -- lualine_b = { {'b:gitsigns_head', icon = ''}, },
      },
    }
  end,
}
