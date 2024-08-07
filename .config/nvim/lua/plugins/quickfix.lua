return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    {
      "<leader>xx",
      function()
        require('trouble').toggle()
      end,
      desc = '[Trouble]Toggle',
    },
    {
      "<leader>xw",
      function()
        require('trouble').toggle 'workspace_diagnostics'
      end,
      desc = '[Trouble]Workspace Diagnostics',
    },
    {
      "<leader>xd",
      function()
        require('trouble').toggle 'document_diagnostics'
      end,
      desc = '[Trouble]Document Diagnostics',
    },
    {
      "<leader>xq",
      function()
        require('trouble').toggle 'quickfix'
      end,
      desc = '[Trouble]Quickfix',
    },
    {
      "<leader>xl",
      function()
        require('trouble').toggle 'loclist'
      end,
      desc = '[Trouble]Loclist',
    },
    {
      "gR",
      function()
        require('trouble').toggle 'lsp_references'
      end,
      desc = '[Trouble]References',
    },
  },
  config = function()
    require('trouble').setup {}
  end,
}
