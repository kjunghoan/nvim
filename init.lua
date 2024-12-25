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
spec("plugins.lsp.typescript") -- TypeScript/JavaScript
spec("plugins.lsp.init") -- Language Server Protocol file
spec("plugins.lsp.java") -- Java

-- Other plugins
spec("plugins.neotest") -- Test Runner
spec("plugins.lazygit") -- Git integrations
spec("plugins.gitsigns") -- Git diff on the side
spec("plugins.none-ls") -- Language Server Protocol file
spec("plugins.harpoon") -- Mark and go back to files
spec("plugins.tmux-nav") -- Tmux navigation
spec("plugins.indent-blankline") -- indents blank lines when pressing tab
spec("plugins.lualine") -- Status line
spec("plugins.luasnip") -- snippets
spec("plugins.mini-icons") -- Icons for the status line
spec("plugins.nvim-ts-autotag") -- Autotags
spec("plugins.nvim-autopairs") -- Auto pairs
spec("plugins.nvim-web-devicons") -- webdev icons
spec("plugins.obsidian") -- Markdown viewer for obsidian vault
spec("plugins.oil") -- File tree
spec("plugins.telescope") -- Fuzzy finder
spec("plugins.treesitter") -- Syntax highlighting
spec("plugins.tailwind-tools") -- Tailwind support
spec("plugins.undotree") -- Undo tree
spec("plugins.which-key") -- Keybinding visualizer

require("config.lazy")
