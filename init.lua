-- Main settings
require("config.launch")
require("config.options")
require("config.globalKeymaps")
require("config.autoCmds")

spec("colorscheme.ayu") -- The default colorscheme

-- Plugins
spec("plugins.harpoon") -- Mark and go back to files
spec("plugins.lsp-config") -- Language Server Protocol file
spec("plugins.lualine") -- Status line
spec("plugins.neo-tree") -- File tree
spec("plugins.none-ls") -- Language Server Protocol file
spec("plugins.oil") -- File tree
spec("plugins.telescope") -- Fuzzy finder
spec("plugins.treesitter") -- Syntax highlighting
spec("plugins.undotree") -- Undo tree
spec("plugins.which-key") -- Keybinding visualizer

require("config.lazy")
