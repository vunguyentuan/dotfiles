return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "LspAttach",
  config = function()
    vim.opt.updatetime = 100
    require('tiny-inline-diagnostic').setup()
    vim.diagnostic.config({ virtual_text = false })
  end
}
