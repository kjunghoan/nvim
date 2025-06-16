-- Main settings
require("config.launch")
require("config.options")
require("config.globalKeymaps")
require("config.autoCmds")

spec("colorscheme.ayu") -- Your colorscheme

-- Language Server Protocols
require("config.lsp")
spec("plugins.mason")

-- Other plugins
spec("plugins.jdtls")             -- Java-specific capabilities
spec("plugins.snacks")            -- Image processor
spec("plugins.blinkcmp")          -- Completions written in rust
spec("plugins.copilot")           -- Copilot
spec("plugins.kulala")            -- REST client
spec("plugins.ltex_extra")        -- LTeX extra features
spec("plugins.autopairs")         -- Auto pairing of brackets, quotes, etc.
spec("plugins.gitsigns")          -- Git diff on the side
spec("plugins.tmux-nav")          -- Tmux navigation
spec("plugins.lualine")           -- Status line
spec("plugins.harpoon")           -- File navigation
spec("plugins.mini-icons")        -- Icons for the status line
spec("plugins.nvim-ts-autotag")   -- auto pairs
spec("plugins.nvim-web-devicons") -- webdev icons
spec("plugins.obsidian")          -- Markdown viewer for obsidian vault
spec("plugins.oil")               -- File tree
spec("plugins.telescope")         -- Fuzzy finder
spec("plugins.treesitter")        -- Syntax highlighting
spec("plugins.undotree")          -- Undo tree
spec("plugins.vim-helm")          -- Helm syntax highlighting
spec("plugins.kubectl")           -- Kubernetes quick commands
spec("plugins.which-key")         -- Keybinding visualizer

require("config.lazy")
