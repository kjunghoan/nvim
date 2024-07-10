-- SOLARIZED OSAKA --
-- local M = {
--   "craftzdog/solarized-osaka.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {}, 
-- }

-- GRUVBOX --
-- local M = {
--   "ellisonleao/gruvbox.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {}
-- }

-- ayu-mirage --
local M = {
  "Shatur/neovim-ayu",
  lazy = false,
  priority = 1000,
  opts = {}
}

function M.config()
--   vim.cmd.colorscheme "solarized-osaka"
--   vim.cmd.colorscheme "gruvbox"
  vim.cmd.colorscheme "ayu-mirage"
end


return M
