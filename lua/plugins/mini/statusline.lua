return {
  "nvim-mini/mini.statusline",
  version = "*",
  config = function()
    require("mini.statusline").setup({
      use_icons = true,
      set_vim_settings = true,
    })
  end,
}
