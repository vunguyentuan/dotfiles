-- Fuzzy Finder Algorithm which requires local dependencies to be built.
-- Only load if `make` is available. Make sure you have the system
-- requirements installed.

return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "FzfLua",
  keys = {
    { "<leader><space>", "<cmd>FzfLua buffers<cr>",    desc = "Switch Buffer" },
    { "<leader>f",       "<cmd>FzfLua files<cr>",      desc = "File files" },
    { "<leader>ss",      "<cmd>FzfLua live_grep<cr>",  desc = "Live grep" },
    { "<leader>gs",      "<cmd>FzfLua git_status<cr>", desc = "Git status" },
  },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({
      -- 'telescope'
      -- 'max-perf'
    })
  end

}
