return {
  -- Theme inspired by Atom
  'catppuccin/nvim',
  name = 'catppuccin',
  enabled = true,
  lazy = false,
  priority = 1000,
  ---@class CatppuccinOptions
  opts = {
    flavour = 'mocha',
    transparent_background = true,

    integrations = {
      cmp = true,
      fidget = true,
      gitsigns = true,
      harpoon = true,
      lsp_trouble = true,
      mason = true,
      neotest = true,
      noice = true,
      notify = true,
      flash = true,
      telescope = {
        enabled = false,
        -- style = "nvchad"
      },

      treesitter = true,
      treesitter_context = true,
      symbols_outline = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { 'italic' },
          hints = { 'italic' },
          warnings = { 'italic' },
          information = { 'italic' },
        },
        underlines = {
          errors = { 'underline' },
          hints = { 'underline' },
          warnings = { 'underline' },
          information = { 'underline' },
        },
      },
    },
    color_overrides = {
      all = {
        surface0 = '#444444',
        surface1 = '#666666',
        surface2 = '#a3a7bc',
        surface3 = '#a3a7bc',
      },
    },
  },
  config = function()
    vim.cmd.colorscheme 'catppuccin'
  end,
}
