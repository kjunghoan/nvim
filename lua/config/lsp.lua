local lsp = vim.lsp

vim.diagnostic.config({
  virtual_text = {current_line = true},
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = vim.o.winborder or "single"
  },
})

-- Global mappings
vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, { desc = "Open Float Diagnostic" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist, { desc = "Diagnostic List" })

-- Use LspAttach autocommand to set up mappings and other settings when an LSP connects to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    
    -- Enable auto-completion from LSP sources
    if lsp.get_client_by_id(ev.data.client_id).supports_method('textDocument/completion') then
      lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = true })
    end

    -- Buffer local mappings using which-key
    local wk = require('which-key')
    wk.register({
      ["<leader>l"] = {
        name = "LSP",
        D = { lsp.buf.declaration, "Go to Declaration" },
        d = { lsp.buf.definition, "Go to Definition" },
        i = { lsp.buf.implementation, "Go to Implementation" },
        r = { lsp.buf.references, "Find References" },
        t = { lsp.buf.type_definition, "Type Definition" },
        k = { lsp.buf.hover, "Hover Documentation" },
        K = { lsp.buf.signature_help, "Signature Help" },
        n = { lsp.buf.rename, "Rename" },
        a = { lsp.buf.code_action, "Code Action" },
        f = { function() lsp.buf.format { async = true } end, "Format" },
      }
    }, { buffer = ev.buf })
  end,
})

-- Load LSP server configurations
lsp.enable({
  'lua_ls',    -- Lua
  'pyright',   -- Python
  'tsserver',  -- TypeScript/JavaScript
  'bashls',    -- Bash
  'yamlls',    -- YAML
  'jdtls',     -- Java
})
