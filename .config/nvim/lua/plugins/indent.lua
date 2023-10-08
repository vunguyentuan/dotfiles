return {
  -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  event = { 'BufReadPre', 'BufNewFile' },

  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help indent_blankline.txt`
  opts = {},
}
