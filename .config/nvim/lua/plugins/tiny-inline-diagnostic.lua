return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "LspAttach",
  enabled = false,

  config = function()
    vim.opt.updatetime = 100
    require('tiny-inline-diagnostic').setup()
    vim.diagnostic.config({ virtual_text = false })
  end
}
