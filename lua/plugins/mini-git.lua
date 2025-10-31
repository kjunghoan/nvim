-- https://github.com/nvim-mini/mini-git
return {
  "nvim-mini/mini-git",
  version = false,
  config = function()
    require("mini.git").setup()
  end,
}
