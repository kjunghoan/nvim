-- lua/config/lsp_setup.lua
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    -- Configure diagnostics
    vim.diagnostic.config({
      virtual_text = true,  -- This is now opt-in
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = { 
        border = vim.o.winborder or "rounded"
      }
    })
    
    -- Set up border for floating windows
    vim.o.winborder = "rounded"
    
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method('textDocument/completion') then
          -- set this up to test sometimes but going to generally use cmp
          -- vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
      end,
    })
    
    -- Create LSP server configs in lsp/ directory
    vim.lsp.enable({
      'lua_ls',    -- Lua
      'pyright',   -- Python
      'ts_ls',     -- TypeScript/JavaScript
      'bashls',    -- Bash
      'yamlls',    -- YAML
      -- Add other servers as needed
    })
  end
}