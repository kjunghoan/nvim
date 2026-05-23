-- https://github.com/hrsh7th/vscode-langservers-extracted
-- JSON / JSONC language server
return {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  root_markers = { ".git" },
  init_options = {
    provideFormatter = true,
  },
}
