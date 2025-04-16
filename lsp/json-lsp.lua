return {
  name = "json-lsp",
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  settings = {
    json = {
      format = {
        enable = true,
      },
      validate = {
        enable = true
      }
    }
  },
  init_options = {
    provideFormatter = true
  },
  on_init = function(client)
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true
  end,
  single_file_support = true,
}

