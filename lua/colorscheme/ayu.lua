return {
  {
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 1000,
    config = function()
      require("ayu").setup({
        mirage = true, -- Set to `true` if you want to use the mirage variant
        overrides = {
          Normal = { bg = "None" },
          NormalFloat = { bg = "none" },
          SignColumn = { bg = "None" },
          Folded = { bg = "None" },
          FoldColumn = { bg = "None" },
          CursorColumn = { bg = "None" },
        }, -- You can add any overrides here
      })
      vim.cmd("colorscheme ayu")
    end,
  },
}
