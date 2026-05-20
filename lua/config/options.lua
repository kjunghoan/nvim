local vo = vim.opt

-- Disable unused providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.scriptencoding = "utf-8"
vo.encoding = "utf-8"
vo.fileencoding = "utf-8"

-- UI settings
vo.number = true
vo.relativenumber = true
vo.cursorline = true -- Highlight the line where the cursor is
vo.wrap = false
vo.breakindent = true
vo.cmdheight = 2 -- Height of the command line
vo.pumheight = 10 -- Height of the popup menu
vo.splitkeep = "cursor" -- Keep the cursor in the same position when splitting windows
vo.splitbelow = true
vo.splitright = true
vo.laststatus = 2
vo.showcmd = true
vo.scrolloff = 10
vim.g.clipboard = "tmux"
vo.clipboard = "unnamedplus"
vo.updatetime = 300
vo.wildmode = "longest:full,full"
vo.wildoptions = "pum"
vo.wildmenu = true
vo.winborder = "rounded"
-- Colorscheme
vo.termguicolors = true
vo.signcolumn = "yes"
vo.colorcolumn = "85"
vo.list = true -- Show invisible characters
vo.listchars:append({ trail = "-" }) -- visible trailing-whitespace marker

-- Indentation and Tab Settings
vo.autoindent = true -- Automatically indent new lines to the same level as the previous line
vo.smartindent = true -- Automatically insert indentation in some cases (e.g., after `{`)
vo.expandtab = true -- Convert tabs to spaces
vo.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for
vo.softtabstop = 2 -- Number of spaces that a <Tab> key press counts as in insert mode
vo.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
vo.smarttab = true -- Insert 'tabstop' number of spaces when pressing <Tab> in front of a line

-- Search Settings
vo.hlsearch = true
vo.incsearch = true
vo.ignorecase = true
vo.smartcase = true -- Override 'ignorecase' if the search pattern contains uppercase characters
vo.wrapscan = true
vo.path:append("**")

vo.wildignore:append({
  ".git",
  "node_modules",
  "vendor",
})

-- Backup and Swap Files
vo.backup = false
vo.writebackup = false
vo.swapfile = false

-- Mouse Settings
vo.mouse = "a" -- To Enable mouse set to "a"

-- Timeout Settings
vo.ttimeoutlen = 10
vo.timeoutlen = 1000

-- General
vo.backspace = { "start", "eol", "indent" }
vo.undofile = true

vim.g.python3_host_prog = require("util.venv").find_project_venv()
