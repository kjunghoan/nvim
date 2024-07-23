local opts = { noremap = true, silent = true }

-- shortened for convenience --
local km = vim.keymap.set

km("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

km('n', '<leader>h', ':nohlsearch<CR>')

