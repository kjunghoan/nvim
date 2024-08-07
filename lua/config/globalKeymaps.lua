local opts = {noremap = true, silent = true}
local km = vim.keymap.set

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
km("", "<Space>", "<Nop>", opts)

-- Move text up and down
km("v", "J", ":m '>+1<CR>gv=gv")
km("v", "K", ":m '<-2<CR>gv=gv")

-- Resize panes with arrows
km("n", "<C-Up>", ":resize +2<CR>", opts)
km("n", "<C-Down>", ":resize -2<CR>", opts)
km("n", "<C-Left>", ":vertical resize +2<CR>", opts)
km("n", "<C-Right>", ":vertical resize -2<CR>", opts)

km('n', '<leader>e', ':Neotree left<CR>', opts, {description = 'Show file tree'})
km('n', '<leader>r', '<cmd>NvimTreeRefresh<cr>', opts)
km('n', '<leader>n', '<cmd>NvimTreeFindFile<cr>', opts)