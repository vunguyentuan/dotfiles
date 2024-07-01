return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  config = function()
    vim.opt.updatetime = 100
    require('tiny-inline-diagnostic').setup()
    vim.diagnostic.config({ virtual_text = false })
  end
}
