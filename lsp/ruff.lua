return {
  cmd = { 'ruff-lsp' },
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
    ruff = {
      path = "",
      format = {
        enabled = true,
      },
      lint = {
        explanations = {
          enabled = true,
        },
        args = {}
      },
    },
    organizeImports = true,
    lineLength = 88,
  },
  on_attach = function(client, bufnr)
    -- disables existing formatter so we use ruff
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
}
