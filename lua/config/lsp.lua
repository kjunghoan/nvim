vim.diagnostic.config({
  virtual_text = { current_line = false },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = vim.o.winborder or "single"
  },
})

-- Global LSP key mappings
vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, { desc = "Open Float Diagnostic" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist, { desc = "Diagnostic List" })
local lsp_group = vim.api.nvim_create_augroup('UserLspConfig', {})
vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_group,
  callback = function(ev)
    local bufnr = ev.buf
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
    local wk = require('which-key')
    wk.add({
      { "<leader>l",  group = "LSP" },
      { "<leader>ld", vim.lsp.buf.declaration,              desc = "Go to Declaration" },
      { "<leader>li", vim.lsp.buf.implementation,           desc = "Go to Implementation" }, --gri
      { "<leader>lr", vim.lsp.buf.references,               desc = "Find References" }, -- grr
      { "<leader>lt", vim.lsp.buf.type_definition,          desc = "Type Definition" },
      { "<leader>lk", vim.lsp.buf.hover,                    desc = "Hover Documentation" },
      { "<leader>lK", vim.lsp.buf.signature_help,           desc = "Signature Help" },
      { "<leader>ln", vim.lsp.buf.rename,                   desc = "Rename" }, --grn
      { "<leader>la", vim.lsp.buf.code_action,              desc = "Code Action" }, --gra
      { "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, desc = "Format" },
    }, { buffer = bufnr })
  end,
})
