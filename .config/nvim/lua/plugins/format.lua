return {
  "nvimdev/guard.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local ft = require('guard.filetype')
    -- multiple files register
    ft('typescript,javascript,typescriptreact'):fmt('prettier')

    -- call setup LAST
    require('guard').setup({
      -- the only options for the setup function
      fmt_on_save = true,
      -- Use lsp if no formatter was defined for this filetype
      lsp_as_default_formatter = true,
    })

    vim.keymap.set({ 'n', 'v' }, '<leader>lf', '<cmd>GuardFmt<CR>', { desc = "Format the code" })
  end,
}
