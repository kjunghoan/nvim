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

-- Define autocmd group for LSP setup
local lsp_group = vim.api.nvim_create_augroup('UserLspConfig', {})
-- Set up buffer-local mappings when an LSP attaches
vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_group,
  callback = function(ev)
    -- Keeping the reference in case we need client-specific settings later
    local bufnr = ev.buf
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings using which-key
    local wk = require('which-key')
    wk.add({
      { "<leader>l",  group = "LSP" },
      { "<leader>lD", vim.lsp.buf.declaration,                        desc = "Go to Declaration" },
      { "<leader>ld", vim.lsp.buf.definition,                         desc = "Go to Definition" },
      { "<leader>li", vim.lsp.buf.implementation,                     desc = "Go to Implementation" },
      { "<leader>lr", vim.lsp.buf.references,                         desc = "Find References" },
      { "<leader>lt", vim.lsp.buf.type_definition,                    desc = "Type Definition" },
      { "<leader>lk", vim.lsp.buf.hover,                              desc = "Hover Documentation" },
      { "<leader>lK", vim.lsp.buf.signature_help,                     desc = "Signature Help" },
      { "<leader>ln", vim.lsp.buf.rename,                             desc = "Rename" },
      { "<leader>la", vim.lsp.buf.code_action,                        desc = "Code Action" },
      { "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, desc = "Format" },
    }, { buffer = bufnr })
  end,
})

vim.lsp.enable({
  'lua_ls',   -- Lua
  'pyright',  -- Python
  'json-lsp', -- Json
  'ts_ls',    -- TypeScript/JavaScript
  'bashls',   -- Bash
  'yamlls',   -- YAML
  -- 'jdtls',   -- Java this is covered by plugins/jdtls as recommended by the docs
  -- 'ltex_ls',  -- LTeX for LaTeX/Markdown grammar checking (Covered by ltex_extra plugin)
})
