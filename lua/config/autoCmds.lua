vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd("set formatoptions-=cro")
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "netrw",
    "Jaq",
    "qf",
    "git",
    "help",
    "man",
    "lspinfo",
    "oil",
    "spectre_panel",
    "lir",
    "DressingSelect",
    "tsplayground",
    "",
  },
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
  end,
})

vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
  callback = function()
    vim.cmd("quit")
  end,
})

vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd("checktime")
  end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 40 })
  end,
})

-- Set filetype for .env and .dev.vars files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".env", ".env.*", "*.dev.vars", "config" },
  callback = function()
    vim.opt_local.filetype = "sh" -- This will give us basic shell script highlighting
  end,
})

vim.api.nvim_create_autocmd({ "CursorHold" }, {
  callback = function()
    local status_ok, luasnip = pcall(require, "luasnip")
    if not status_ok then
      return
    end
    if luasnip.expand_or_jumpable() then
      vim.cmd([[silent! lua require("luasnip").unlink_current()]])
    end
  end,
})

-- Set filetype for helm templates
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*/templates/*.yaml", "*/templates/*.tpl", "*.gotmpl", "helmfile*.yaml" },
  callback = function()
    vim.bo.filetype = "helm"
  end
})

-- Makefile support
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "Makefile", "makefile", "*.mk", "*.make" },
  callback = function()
    vim.bo.filetype = "make"
    vim.bo.tabstop = 4
    vim.bo.shiftwidth = 4

    -- Quick make commands
    local wk = require("which-key")
    wk.add({
      { "<leader>m",  group = "Make" },
      { "<leader>mm", ":!make<CR>",         desc = "Make" },
      { "<leader>mc", ":!make clean<CR>",   desc = "Make Clean" },
      { "<leader>mt", ":!make test<CR>",    desc = "Make Test" },
      { "<leader>mr", ":!make run<CR>",     desc = "Make Run" },
      { "<leader>mi", ":!make install<CR>", desc = "Make Install" },
      { "<leader>mb", ":!make build<CR>",   desc = "Make Build" },
    }, { buffer = vim.api.nvim_get_current_buf() })
  end,
})
