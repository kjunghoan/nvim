-- Main settings
require("config.launch")
require("config.options")
require("config.globalKeymaps")
require("config.autoCmds")

spec("colorscheme.ayu") -- The default colorscheme
-- Plugins
spec("plugins.lualine") -- Status line
spec("plugins.neo-tree") -- File tree
spec("plugins.telescope") -- Fuzzy finder
spec("plugins.treesitter") -- Syntax highlighting
spec("plugins.which-key") -- Keybinding visualizer

require("config.lazy")
