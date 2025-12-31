return {
  "nvim-mini/mini.comment",
  version = "*",
  config = function()
    require("mini.comment").setup({
      options = {
        ignore_blank_lines = true,
      },
    })
  end,
}
