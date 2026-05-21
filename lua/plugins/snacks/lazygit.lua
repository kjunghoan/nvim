-- https://github.com/folke/snacks.nvim/blob/main/docs/lazygit.md
return {
  opts = { lazygit = { enabled = true } },
  keys = {
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
  },
}
