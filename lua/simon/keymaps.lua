local opts = { noremap = true, silent = true }

-- Shorten for convenience
local keymap = vim.keymap.set

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Window Navigation --
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-7>", ":resize -2<CR>", opts)
keymap("n", "<C-8>", ":resize +2<CR>", opts)
keymap("n", "<C-9>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-0>", ":vertical resize +2<CR>", opts)

-- Move text up and down --
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- Misc. --
keymap("i", "jj", "<ESC>", { desc = "Exit insert mode with jk" }) -- use jj to exit insert mode
keymap("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" }) -- nh to clear search highlights
keymap("i", "<C-c>", "<Esc>") -- set <C-c> to be <Esc>
keymap("n", "<C-q>", "gg<S-v>G") -- select all
keymap("n", "<leader>pv", vim.cmd.Oil) -- go back to explorer
