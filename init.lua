-- Main settings
require("config.launch")
require("config.options")
require("config.globalKeymaps")
require("config.autoCmds")

spec("colorscheme.ayu") -- Your colorscheme

-- Language Server Protocols
require("config.lsp")

-- Other plugins
spec("plugins.mason")
spec("plugins.blinkcmp") -- Completions written in rust
spec("plugins.gitsigns") -- Git diff on the side
spec("plugins.tmux-nav") -- Tmux navigation
spec("plugins.lualine") -- Status line
spec("plugins.mini-icons") -- Icons for the status line
spec("plugins.nvim-web-devicons") -- webdev icons
spec("plugins.obsidian") -- Markdown viewer for obsidian vault
spec("plugins.oil") -- File tree
spec("plugins.telescope") -- Fuzzy finder
spec("plugins.treesitter") -- Syntax highlighting
spec("plugins.undotree") -- Undo tree
spec("plugins.which-key") -- Keybinding visualizer

require("config.lazy")
