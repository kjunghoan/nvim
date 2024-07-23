return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register({
      ["<leader>"] = {
        f = { name = "File" },
        b = { name = "Buffer" },
        s = { name = "Search" },
        g = { name = "Git" },
        l = { name = "LSP" },
      },
    })
  end,
}