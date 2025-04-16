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

  -- Disable formatting via ts_ls if you prefer to use other formatters
  -- like prettier via null-ls/conform
  on_attach = function(_, bufnr) -- change _ to client if you want to use the client object
    -- Disable tsserver formatting if you plan to use other formatters
    -- client.server_capabilities.documentFormattingProvider = false
    -- client.server_capabilities.documentRangeFormattingProvider = false

    -- Add shortcut for organizing imports
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

  -- Support single files without a project
  single_file_support = true,
}
