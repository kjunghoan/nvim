-- Main settings
require("config.launch")
require("config.options")
require("config.globalKeymaps")
require("config.autoCmds")

spec("colorscheme.ayu") -- The default colorscheme

-- Plugins
spec("plugins.cmp") -- Code completions
spec("plugins.comment") -- Batch Commenting
spec("plugins.copilot") -- Github Copilot
spec("plugins.debugging") -- Debuggers and dap
-- Currently Installed Debuggers:()
spec("plugins.git") -- Git integrations
spec("plugins.harpoon") -- Mark and go back to files
spec("plugins.indent-blankline") -- indents blank lines when pressing tab
spec("plugins.lsp-config") -- Language Server Protocol file
spec("plugins.lualine") -- Status line
spec("plugins.luasnip") -- snippets
spec("plugins.mini-icons") -- Icons for the status line
spec("plugins.testing") -- Test Runner (neotest, codium)
spec("plugins.none-ls") -- Language Server Protocol file
spec("plugins.nvim-ts-autotag") -- Autotags
spec("plugins.nvim-autopairs") -- Auto pairs
spec("plugins.nvim-java") -- Java Language Server
spec("plugins.nvim-web-devicons") -- webdev icons
spec("plugins.obsidian") -- Markdown viewer for obsidian vault
spec("plugins.oil") -- File tree
spec("plugins.tailwind-tools") -- Tailwind support
spec("plugins.telekasten") -- Zetelkasten support for wikilinks
spec("plugins.telescope") -- Fuzzy finder
spec("plugins.treesitter") -- Syntax highlighting
spec("plugins.undotree") -- Undo tree
spec("plugins.which-key") -- Keybinding visualizer

require("config.lazy")
