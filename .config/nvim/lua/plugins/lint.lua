return {
  'mfussenegger/nvim-lint',
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = {
      javascript = {
        'oxlint',
      },
      typescript = {
        'oxlint',
      },
      javascriptreact = {
        'oxlint',
      },
      typescriptreact = {
        'oxlint',
      },
    }
  end,
}
