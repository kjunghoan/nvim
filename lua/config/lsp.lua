vim.lsp.config("*", {
  root_markers = { ".git" },
})

for _, file in ipairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
  local name = file:match("lsp/(.+)%.lua$")
  if name then
    vim.lsp.enable(name)
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, {
        buffer = bufnr,
        noremap = true,
        silent = true,
        desc = desc,
      })
    end

    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "gT", vim.lsp.buf.type_definition, "Go to type definition")
    map("n", "<leader>ld", vim.diagnostic.open_float, "Show diagnostic")
  end,
})

vim.diagnostic.config({
  virtual_lines = { current_line = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.HINT] = "⚑",
      [vim.diagnostic.severity.INFO] = "»",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    source = true,
  },
})

vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"
-- without these two, foldmethod=expr closes every fold on open
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
