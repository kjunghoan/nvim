-- https://github.com/Shatur/neovim-ayu
vim.pack.add({ "https://github.com/Shatur/neovim-ayu" })
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
