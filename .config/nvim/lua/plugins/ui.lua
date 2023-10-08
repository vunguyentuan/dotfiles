return {
  {
    'smjonas/inc-rename.nvim',
    enabled = false,
    keys = {
      {
        '<leader>rn',
        function()
          return ':IncRename ' .. vim.fn.expand '<cword>'
        end,
        desc = 'LSP Rename',
        expr = true,
      },
    },
    dependencies = {
      'folke/noice.nvim',
    },
    config = function()
      require('inc_rename').setup()
    end,
  },
}
