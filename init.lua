-- Main settings
require("config.launch")
require("config.options")
require("config.globalKeymaps")
require("config.autoCmds")

spec("colorscheme.ayu") -- Your colorscheme

-- Must load first
spec("plugins.mason") -- Mason needs to load first
spec("plugins.cmp")

-- Language Server Protocols

spec("plugins.lsp") -- Language Server Protocol file
spec("plugins.ltex") -- Grammar and spell checker

-- Other plugins
spec("plugins.snacks") -- image viewer
-- spec("plugins.himalaya") -- email client
spec("plugins.gitsigns") -- Git diff on the side
spec("plugins.none-ls") -- Language Server Protocol file
spec("plugins.indent-blankline") -- indents blank lines when pressing tab
spec("plugins.lualine") -- Status line
spec("plugins.mini-icons") -- Icons for the status line
spec("plugins.nvim-autopairs") -- Auto pairs
spec("plugins.nvim-web-devicons") -- webdev icons
spec("plugins.obsidian") -- Markdown viewer for obsidian vault
spec("plugins.oil") -- File tree
spec("plugins.telescope") -- Fuzzy finder
spec("plugins.terminal") -- Creates terminals in their own buffers
spec("plugins.treesitter") -- Syntax highlighting
spec("plugins.undotree") -- Undo tree
spec("plugins.which-key") -- Keybinding visualizer

require("config.lazy")
