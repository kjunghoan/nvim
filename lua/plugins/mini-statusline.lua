-- https://github.com/nvim-mini/mini.statusline
return {
  "nvim-mini/mini.statusline",
  version = false,
  config = function()
    require("mini.statusline").setup({
      use_icons = true,
      set_vim_settings = true,
    })
  end,
}
