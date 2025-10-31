-- https://github.com/Shatur/neovim-ayu
return {
  {
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 1000,
    config = function()
      require("ayu").setup({
        mirage = true,
        overrides = {
          Normal = { bg = "None" },
          NormalFloat = { bg = "none" },
          SignColumn = { bg = "None" },
          Folded = { bg = "None" },
          FoldColumn = { bg = "None" },
          CursorColumn = { bg = "None" },
        },
      })
      vim.cmd("colorscheme ayu")
    end,
  },
}
