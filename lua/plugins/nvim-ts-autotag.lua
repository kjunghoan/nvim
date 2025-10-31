-- https://github.com/windwp/nvim-ts-autotag
return {
  "windwp/nvim-ts-autotag",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-ts-autotag").setup()
  end,
}
