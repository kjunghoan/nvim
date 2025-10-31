local opts = { noremap = true, silent = true }
local km = vim.keymap.set

-- Leader key is set in init.lua before this file loads
-- No need to remap space to Nop when using it as leader

-- Move text up and down
km("v", "J", ":m '>+1<CR>gv=gv")
km("v", "K", ":m '<-2<CR>gv=gv")

-- Resize panes with arrows
km("n", "<C-S-Up>", ":resize +2<CR>", opts)
km("n", "<C-S-Down>", ":resize -2<CR>", opts)
km("n", "<C-S-Left>", ":vertical resize +2<CR>", opts)
km("n", "<C-S-Right>", ":vertical resize -2<CR>", opts)

-- Split windows
km("n", "<leader>sv", ":vsplit<CR>", { noremap = true, silent = true, desc = "Split vertically" })
km("n", "<leader>sh", ":split<CR>", { noremap = true, silent = true, desc = "Split Horizontally" })

-- Wrap lines toggle
km("n", "<leader>w", ":set wrap!<CR>", { noremap = true, silent = true, desc = "Toggle Wrap" })

-- Clear search highlight
km("n", "<leader>h", ":nohlsearch<CR>", { noremap = true, silent = true, desc = "Clear Search Highlight" })
