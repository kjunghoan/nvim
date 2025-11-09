return {
  "gisketch/triforce.nvim",
  dependencies = {
    "nvzone/volt",
  },
  config = function()
    require("triforce").setup({
      -- Optional: Add your configuration here
      keymap = {
        show_profile = "<leader>Tp", -- Open profile with <leader>tp
      },
    })
  end,
}
