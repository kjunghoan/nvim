return {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  root_markers = { "package.json", ".git" },
  settings = {
    json = {
      format = { enable = true },
      validate = { enable = true }
    }
  },
  init_options = {
    provideFormatter = true
  },
  single_file_support = true,
}
