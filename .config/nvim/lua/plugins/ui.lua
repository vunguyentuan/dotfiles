return {
  {
    "smjonas/inc-rename.nvim",
    keys = {
      { "<leader>rn", "<cmd>IncRename<cr>", desc = "LSP Rename" },
    },
    dependencies = {
      "folke/noice.nvim",
    },
    config = function()
      require("inc_rename").setup()
    end,
  }
}
