vim.pack.add({
  "https://github.com/nvim-mini/mini.statusline",
  "https://github.com/nvim-mini/mini.ai",
  "https://github.com/nvim-mini/mini.surround",
})
require("mini.statusline").setup()
require("mini.surround").setup()
require("mini.ai").setup()
