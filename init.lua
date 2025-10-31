-- Main settings
vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("config.launch")
require("config.options")
require("config.filetypes")
require("config.globalKeymaps")
require("config.autoCmds")
require("config.lemonade")
require("config.lsp")

-- Other
spec("colorscheme")

-- plugins
-- spec("plugins.which-key") -- Commented out, trying mini.clue instead
spec("plugins.mini-icons")
spec("plugins.mini-clue")
spec("plugins.mini-statusline")
spec("plugins.mini-git")
spec("plugins.mini-diff")
spec("plugins.mini-pairs")
spec("plugins.tmux-nav")
spec("plugins.oil")
spec("plugins.mini-pick")
spec("plugins.mini-extra")
spec("plugins.blink-cmp")
spec("plugins.treesitter")
spec("plugins.nvim-ts-autotag")
spec("plugins.undotree")
spec("plugins.copilot")
spec("plugins.kulala")
spec("plugins.obsidian")
spec("plugins.kubectl")
spec("plugins.mason")
spec("plugins.mason-tool-installer")
spec("plugins.conform")
spec("plugins.dap")
spec("plugins.jdtls")
spec("plugins.image")

require("config.lazy")
