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
spec("plugins.treesitter")
spec("plugins.blink-cmp")
spec("plugins.snacks.root")
spec("plugins.oil")
spec("plugins.tmux-nav")
spec("plugins.mini")
spec("plugins.nvim-autopairs")
spec("plugins.treesj")
spec("plugins.nvim-web-devicons")
spec("plugins.gitsigns")
spec("plugins.undotree")
spec("plugins.windsurf")

require("config.lazy")
