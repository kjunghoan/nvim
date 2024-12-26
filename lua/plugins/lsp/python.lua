return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  opts = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    return {
      servers = {
        -- Pyright configuration
        pyright = {
          capabilities = capabilities,
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "basic",
                inlayHints = {
                  variableTypes = true,
                  functionReturnTypes = true,
                  pytestParameters = true,
                },
              },
            },
          },
          root_dir = require("lspconfig.util").root_pattern(
            "pyproject.toml",
            "setup.py",
            "setup.cfg",
            "requirements.txt",
            "Pipfile",
            "pyrightconfig.json",
            ".git"
          ),
        },

        -- Ruff configuration
        ruff_lsp = {
          capabilities = capabilities,
          init_options = {
            settings = {
              -- Ruff settings
              ruff = {
                lint = {
                  -- Enable Ruff's formatter
                  enable = true,
                },
                format = {
                  -- Defer to black for formatting
                  enable = false,
                },
              },
            },
          },
          on_attach = function(client, _)
            -- Disabled formatting from ruff-lsp since we're using black
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },
      },
    }
  end,
}