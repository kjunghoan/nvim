local opts = { noremap = true, silent = true }
local km = vim.keymap.set

-- Move text up and down
km("v", "J", ":m '>+1<CR>gv=gv", opts)
km("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Tabs (F3/F4: e/r on layer 3)
km("n", "<leader>n", ":tabnew<CR>", { noremap = true, silent = true, desc = "New Tab" })
km("n", "<F3>", ":tabprevious<CR>", { noremap = true, silent = true, desc = "Prev Tab" })
km("n", "<F4>", ":tabnext<CR>", { noremap = true, silent = true, desc = "Next Tab" })

-- Resize panes (F6-F9)
km(
  "n",
  "<F6>",
  ":vertical resize -2<CR>",
  { noremap = true, silent = true, desc = "Resize Left" }
)
km("n", "<F7>", ":resize -2<CR>", { noremap = true, silent = true, desc = "Resize Down" })
km("n", "<F8>", ":resize +2<CR>", { noremap = true, silent = true, desc = "Resize Up" })
km(
  "n",
  "<F9>",
  ":vertical resize +2<CR>",
  { noremap = true, silent = true, desc = "Resize Right" }
)
km("n", "<F10>", "<C-w>=", { noremap = true, silent = true, desc = "Equalize Panes" })

-- Split windows
km(
  "n",
  "<leader>sv",
  ":vsplit<CR>",
  { noremap = true, silent = true, desc = "Split vertically" }
)
km(
  "n",
  "<leader>sh",
  ":split<CR>",
  { noremap = true, silent = true, desc = "Split Horizontally" }
)

-- Toggle wrap with linebreak
km("n", "<leader>w", function()
  vim.opt.wrap = not vim.opt.wrap:get()
  vim.opt.linebreak = not vim.opt.linebreak:get()
end, { noremap = true, silent = true, desc = "Toggle Wrap at Words" })

-- Clear search highlight
km(
  "n",
  "<leader>h",
  ":nohlsearch<CR>",
  { noremap = true, silent = true, desc = "Clear Search Highlight" }
)

-- Lazygit
km("n", "<leader>gg", function()
  vim.cmd("tabnew term://lazygit")
  vim.cmd("startinsert")
end, { noremap = true, silent = true, desc = "Lazygit" })
