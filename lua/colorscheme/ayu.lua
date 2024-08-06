return {
  {
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 1000,
    config = function()
      require("ayu").setup({
        mirage = true, -- Set to `true` if you want to use the mirage variant
        overrides = {}, -- You can add any overrides here
      })
      vim.cmd("colorscheme ayu")
    end,
  },
}