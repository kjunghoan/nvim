return {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx'
  },
  -- Files that help identify the project root directory
  root_markers = {
    'tsconfig.json',
    'jsconfig.json',
    'package.json',
    '.git'
  },
  -- Initialize with Neovim-specific settings
  init_options = {
    hostInfo = 'neovim',
    -- Uncomment to enable TypeScript plugin support (like Vue)
    -- plugins = {
    --   {
    --     name = "@vue/typescript-plugin",
    --     location = "/path/to/node_modules/@vue/typescript-plugin",
    --     languages = {"javascript", "typescript", "vue"},
    --   },
    -- },
  },

  -- Language server specific settings
  settings = {
    typescript = {
      inlayHints = {
        -- Show parameter name hints
        includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all'
        -- Don't show parameter hints when parameter name matches the argument name
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        -- Show function return type hints
        includeInlayFunctionLikeReturnTypeHints = true,
        -- Show hints for property declarations
        includeInlayPropertyDeclarationTypeHints = true,
        -- Show variable type hints
        includeInlayVariableTypeHints = true,
      },
      format = {
        indentSize = 2,
        convertTabsToSpaces = true,
        tabSize = 2,
      },
      suggest = {
        completeFunctionCalls = true,
      },
      checkJs = true,
      diagnostics = {
        enable = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = false,
      },
      format = {
        indentSize = 2,
        convertTabsToSpaces = true,
        tabSize = 2,
      },
      suggest = {
        completeFunctionCalls = true,
      },
    },
  },

  on_attach = function(client)
    -- Disable formatting - will be handled by conform.nvim
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,

  -- Support single files without a project
  single_file_support = true,
}
