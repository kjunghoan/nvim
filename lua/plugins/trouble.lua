-- https://github.com/folke/trouble.nvim
return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  config = function()
    require("trouble").setup({})
  end,
}
