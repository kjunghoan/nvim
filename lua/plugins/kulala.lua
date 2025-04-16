return {
  "mistweaverco/kulala.nvim",
  lazy = false,
  ft = {"http", "rest"},
  keys = {
    { "<leader>Rs", desc = "Send request" },
    { "<leader>Ra", desc = "Send all requests" },
    { "<leader>Rb", desc = "Open scratchpad" },
  },
  config = function()
    local kulala = require("kulala")

    kulala.setup({
      global_keymaps = true,
    })
  end,
}
