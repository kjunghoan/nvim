local augroup = vim.api.nvim_create_augroup("UserAutoCmds", { clear = true })

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = augroup,
  callback = function()
    vim.opt.formatoptions:remove("cro")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = {
    "netrw",
    "qf",
    "git",
    "help",
    "man",
    "lspinfo",
    "oil",
  },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = true, silent = true })
    vim.opt_local.buflisted = false
  end,
})

vim.api.nvim_create_autocmd("CmdWinEnter", {
  group = augroup,
  callback = function()
    vim.cmd("quit")
  end,
})

vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = augroup,
  callback = function()
    vim.cmd("checktime")
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 40 })
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup,
  pattern = { ".env", ".env.*", "*.dev.vars" },
  callback = function()
    vim.opt_local.filetype = "sh"
  end,
})

