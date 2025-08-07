-- lsp/pyright.lua
return {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git'
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
        typeCheckingMode = "strict",
        autoImportCompletions = true,
        indexing = true,
        packageIndexDepths = {
          torch = 3,
          transformers = 3,
          numpy = 2,
          pandas = 2,
          datatets = 2,
          tokenizers = 2,
          accelerate = 2,
        },
      },
      -- pythonPath = vim.fn.expand("~/.config/nvim/venv/neovim/bin/python3"),
    },
  },
  single_file_support = true,
}
