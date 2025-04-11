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
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ direction = "prev", count = 1 }) end,
  { desc = "Previous Diagnostic" })
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ direction = "next", count = 1 }) end,
  { desc = "Next Diagnostic" })
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
    wk.register({
      ["<leader>l"] = {
        name = "LSP",
        D = { vim.lsp.buf.declaration, "Go to Declaration" },
        d = { vim.lsp.buf.definition, "Go to Definition" },
        i = { vim.lsp.buf.implementation, "Go to Implementation" },
        r = { vim.lsp.buf.references, "Find References" },
        t = { vim.lsp.buf.type_definition, "Type Definition" },
        k = { vim.lsp.buf.hover, "Hover Documentation" },
        K = { vim.lsp.buf.signature_help, "Signature Help" },
        n = { vim.lsp.buf.rename, "Rename" },
        a = { vim.lsp.buf.code_action, "Code Action" },
        f = { function() vim.lsp.buf.format({ async = true }) end, "Format" },
      }
    }, { buffer = bufnr })
  end,
})

vim.lsp.enable({
  'lua_ls',  -- Lua
  'pyright', -- Python
  'ts_ls',   -- TypeScript/JavaScript
  'bashls',  -- Bash
  'yamlls',  -- YAML
  'jdtls',   -- Java
})
