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
spec("plugins.gitsigns")
spec("plugins.mini")
spec("plugins.tmux-nav")
spec("plugins.oil")
spec("plugins.blink-cmp")
spec("plugins.treesitter")
spec("plugins.nvim-ts-autotag")
spec("plugins.undotree")
spec("plugins.copilot")
spec("plugins.kulala")
spec("plugins.obsidian")
spec("plugins.kubectl")
spec("plugins.mason")
spec("plugins.nvim-lspconfig")
spec("plugins.mason-lspconfig")
spec("plugins.conform")
spec("plugins.nvim-lint")
spec("plugins.dap")
spec("plugins.image")
spec("plugins.render-markdown")
spec("plugins.vimtex")
-- spec("plugins.nomad")
spec("plugins.typstPreview")
spec("plugins.harpoon")

require("config.lazy")
