-- lsp/ts_ls.lua
return {
  cmd = { 'typescript-language-server', '--stdio' },
  root_markers = { 
    'tsconfig.json', 
    'package.json', 
    'jsconfig.json', 
    '.git' 
  },
  filetypes = { 
    'typescript', 
    'typescriptreact', 
    'javascript', 
    'javascriptreact' 
  },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
      },
      format = {
        indentSize = 2,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
      },
      format = {
        indentSize = 2,
      },
    },
  },
  -- This disables formatting from ts_ls, allowing you to use a different formatter
  -- like null-ls or conform.nvim with prettier
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end
}