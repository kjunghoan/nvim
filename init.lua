-- Main settings
vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("config.launch")
pcall(require, "local-config") -- Load local config if it exists
require("config.options")
require("config.filetypes")
require("config.globalKeymaps")
require("config.autoCmds")
require("config.lemonade")
require("config.lsp")

-- Other
spec("colorscheme")

-- plugins
-- spec("plugins.gitsigns")

require("config.lazy")
