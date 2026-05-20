-- Main settings
vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("config.launch")
pcall(require, "local-config") -- Load local config if it exists
require("config.options")
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
spec("plugins.harpoon")
spec("plugins.conform")
spec("plugins.nvim-lint")
spec("plugins.obsidian")
spec("plugins.kubectl")
spec("plugins.dadbod")
spec("plugins.typst-preview")
spec("plugins.trouble")
spec("plugins.todo-comments")
spec("plugins.diffview")

require("config.lazy")
