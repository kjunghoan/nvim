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
vo.cursorline = true         -- Highlight the line where the cursor is
vo.wrap = false              -- Don't wrap lines (togglable)
vo.breakindent = true        -- Keep the indentation when wrapping lines
vo.cmdheight = 2             -- Height of the command line
vo.pumheight = 10            -- Height of the popup menu
vo.splitkeep = "cursor"      -- Keep the cursor in the same position when splitting windows
vo.splitbelow = true         -- Put new windows below current
vo.splitright = true         -- Put new windows right of current
vo.laststatus = 2            -- Always show the status line
vo.showcmd = true            -- Show the command being typed
vo.scrolloff = 10            -- Keep 10 lines above and below the cursor
vim.g.clipboard = "tmux"
vo.clipboard = "unnamedplus"
vo.updatetime = 300          -- Faster completion
vo.wildmode = "longest:full,full"
vo.wildoptions = "pum"
vo.wildmenu = true
vo.winborder = "single"
-- Colorscheme
vo.termguicolors = true
vo.signcolumn = "yes"  -- Always show the sign column
vo.colorcolumn = "100" -- Highlight the 80th column
vo.list = true         -- Show invisible characters
-- Toggle line wrapping function

-- Indentation and Tab Settings
vo.autoindent = true  -- Automatically indent new lines to the same level as the previous line
vo.smartindent = true -- Automatically insert indentation in some cases (e.g., after `{`)
vo.expandtab = true   -- Convert tabs to spaces
vo.tabstop = 2        -- Number of spaces that a <Tab> in the file counts for
vo.softtabstop = 2    -- Number of spaces that a <Tab> key press counts as in insert mode
vo.shiftwidth = 2     -- Number of spaces to use for each step of (auto)indent
vo.smarttab = true    -- Insert 'tabstop' number of spaces when pressing <Tab> in front of a line

-- Search Settings
vo.hlsearch = true -- Highlight search results
vo.incsearch = true -- Incremental search
vo.ignorecase = true -- Ignore case when searching
vo.smartcase = true -- Override 'ignorecase' if the search pattern contains uppercase characters
vo.wrapscan = true -- Searches wrap around the end of the file
vo.path:append("**") -- Search in the current directory and its subdirectories

vo.wildignore:append({ -- Ignore these directories when searching
  ".git",
  "node_modules",
  "vendor"
})

-- Spell Checking
vo.spell = true           -- Enable spell checking
vo.spelllang = "en_us"    -- Set spellcheck language

-- Backup and Swap Files
vo.backup = false      -- Don't create backup files
vo.writebackup = false -- Don't create a backup before overwriting a file
vo.swapfile = false    -- Don't use swap files

-- Mouse Settings
vo.mouse = "a" -- To Enable mouse set to "a"

-- Timeout Settings
vo.ttimeoutlen = 10 -- Wait indefinitely for key codes
vo.timeoutlen = 300 -- Time in milliseconds to wait for a key code

-- General
vo.backspace = { "start", "eol", "indent" } -- Allow backspacing over everything in insert mode
vo.undofile = true                          -- Save undo history to a file

-- Auto-detect Python virtual environments
local function find_project_venv()
  local cwd = vim.fn.getcwd()

  -- First check exact common venv directory names
  local exact_names = {
    "venv",
    ".venv",
    "env",
    ".env",
    "virtualenv",
    ".virtualenv"
  }

  -- Check for exact matches first
  for _, name in ipairs(exact_names) do
    local venv_path = cwd .. "/" .. name .. "/bin/python3"
    if vim.fn.executable(venv_path) == 1 then
      return venv_path
    end
  end

  -- Check for directories that contain common venv patterns
  local patterns = { "env", "venv", "virtualenv" }
  local dirs = vim.fn.glob(cwd .. "/*", false, true)

  -- Safety check - make sure the dir is a table
  if type(dirs) == "table" then
    for _, dir in ipairs(dirs) do
      if vim.fn.isdirectory(dir) == 1 then
        local dir_name = vim.fn.fnamemodify(dir, ":t")
        for _, pattern in ipairs(patterns) do
          if dir_name:match(pattern) then
            local python_path = dir .. "/bin/python3"
            if vim.fn.executable(python_path) == 1 then
              return python_path
            end
          end
        end
      end
    end
  end

  -- Check parent directories (useful for nested project structures)
  local parent = vim.fn.fnamemodify(cwd, ':h')
  while parent ~= '/' and parent ~= vim.fn.expand('~') do
    for _, name in ipairs(exact_names) do
      local venv_path = parent .. "/" .. name .. "/bin/python3"
      if vim.fn.executable(venv_path) == 1 then
        return venv_path
      end
    end
    parent = vim.fn.fnamemodify(parent, ':h')
  end

  -- Fallback to the default nvim venv
  return vim.fn.expand("~/.config/nvim/venv/neovim/bin/python3")
end

-- Set the Python host program
vim.g.python3_host_prog = find_project_venv()

-- Also set it up to re-detect when changing directories
vim.api.nvim_create_autocmd("DirChanged", {
  callback = function()
    vim.g.python3_host_prog = find_project_venv()
  end,
})
