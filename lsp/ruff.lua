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
  settings = {},
  on_attach = function()
    -- Enable formatting capabilities
    -- client.server_capabilities.documentFormattingProvider = true
    -- client.server_capabilities.documentRangeFormattingProvider = true

  end,
  single_file_support = true,
}
