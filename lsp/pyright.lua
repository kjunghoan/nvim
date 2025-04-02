-- lsp/pyright.lua
return {
  cmd = { 'pyright-langserver', '--stdio' },
  root_markers = { 
    'pyproject.toml', 
    'setup.py', 
    'setup.cfg', 
    'requirements.txt', 
    'Pipfile', 
    '.git' 
  },
  filetypes = { 'python' },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
        typeCheckingMode = "basic",
      },
    },
  },
}