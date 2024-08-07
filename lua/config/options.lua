local vo = vim.opt

vim.scriptencoding = "utf-8"
vo.encoding = "utf-8"
vo.fileencoding = "utf-8"

-- UI settings
vo.number = true
vo.relativenumber = true
vo.cursorline = true -- highlight the line where the cursor is
vo.wrap = false -- don't wrap lines (toggleable)
vo.breakindent = true -- keep the indentation when wrapping lines
vo.cmdheight = 2 -- height of the command line
vo.pumheight = 10 -- height of the popup menu
vo.splitkeep = "cursor" -- keep the cursor in the same position when splitting windows
vo.splitbelow = true -- Put new windows below current
vo.splitright = true -- Put new windows right of current
vo.laststatus = 2 -- Always show the status line
vo.showcmd = true -- Show the command being typed
vo.scrolloff = 10 -- Keep 10 lines above and below the cursor
vim.opt.clipboard = 'unnamedplus' -- Use the system clipboard
vim.opt.updatetime = 300 -- Faster completion
-- Colorscheme
vo.termguicolors = true
vo.signcolumn = "yes" -- always show the sign column
vo.colorcolumn = "80" -- highlight the 80th column
vo.list = true -- show invisible characters
-- Toggle line wrapping function
function ToggleWrap() -- TODO
  if vo.wrap:get() then
    vo.wrap = false
  else
    vo.wrap = true
  end
end


-- Indentation and Tab Settings
vo.autoindent = true      -- Automatically indent new lines to the same level as the previous line
vo.smartindent = true     -- Automatically insert indentation in some cases (e.g., after `{`)
vo.expandtab = true       -- Convert tabs to spaces
vo.tabstop = 2            -- Number of spaces that a <Tab> in the file counts for
vo.softtabstop = 2        -- Number of spaces that a <Tab> key press counts for while editing
vo.shiftwidth = 2         -- Number of spaces to use for each step of (auto)indent
vo.smarttab = true        -- Insert 'tabstop' number of spaces when pressing <Tab> in front of a line


-- Search Settings
vo.hlsearch = true        -- Highlight search results
vo.incsearch = true       -- Incremental search
vo.ignorecase = true      -- Ignore case when searching
vo.smartcase = true       -- Override 'ignorecase' if the search pattern contains uppercase characters
vo.wrapscan = true        -- Searches wrap around the end of the file
vo.wildignore:append({ ".git", "node_modules", "vendor" }) -- Ignore these directories when searching
vo.path:append("**") -- Search in the current directory and its subdirectories

-- Backup and Swap Files
vo.backup = false         -- Don't create backup files
vo.writebackup = false    -- Don't create a backup before overwriting a file
vo.swapfile = false       -- Don't use swap files

-- Mouse Settings
vo.mouse = "a"            -- Enable mouse support in all modes (TODO)

-- Timeout Settings
vo.ttimeoutlen = 10        -- Wait indefinitely for key codes
vo.timeoutlen = 300        -- Time in milliseconds to wait for a key code

-- Editor Settings

-- General
vo.backspace = { "start", "eol", "indent" } -- Allow backspacing over everything in insert mode
vo.undofile = true -- Save undo history to a file

-- Undercurl
-- vo.cmd([[let &t_Cs = "\e[4:3m"]]) -- Undercurl color
-- vo.cmd([[let &t_Ce = "\e[4:0m"]]) -- Reset undercurl color

-- disable provider
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
