-- lsp/ruff.lua - Updated for modern ruff server
return {
  cmd = { 'ruff', 'server', '--preview' }, -- Changed from 'ruff-lsp'
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.ruff.toml',
    'ruff.toml',
    '.git',
  },
  settings = {
    -- Ruff server settings (simplified compared to ruff-lsp)
  },
  on_attach = function(client, bufnr)
    -- Enable formatting capabilities
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true

    vim.keymap.set('n', '<leader>lyo', function()
      vim.lsp.buf.code_action({
        context = {
          only = { "source.organizeImports" },
          diagnostics = vim.diagnostic.get(bufnr)
        },
        apply = true,
      })
    end, { buffer = bufnr, desc = "Organize Imports" })
  end,
  single_file_support = true,
}
