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
          root_dir = function(fname)
            local util = require("lspconfig.util")
            local project_root =
              util.root_pattern("pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git")(fname)

            if project_root == nil then
              if fname:match("%.py$") then
                return util.path.dirname(fname)
              end
            end

            return project_root
          end,
        },

        -- Ruff configuration
        ruff_lsp = {
          capabilities = capabilities,
          init_options = {
            settings = {
              ruff = {
                lint = {
                  enable = true,
                },
                format = {
                  -- Allow formatting even in non-project directories
                  enable = true,
                },
              },
            },
          },
          -- Also enable formatting from ruff-lsp when in non-project directories
          on_attach = function(client, bufnr)
            -- Remove this line to enable formatting from ruff-lsp
            -- client.server_capabilities.documentFormattingProvider = false
            -- client.server_capabilities.documentRangeFormattingProvider = false

            vim.keymap.set("n", "<leader>lf", function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end, { buffer = bufnr, desc = "Format buffer with LSP" })
          end,
          root_dir = function(fname)
            local util = require("lspconfig.util")
            local project_root = util.root_pattern("pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git")(fname)

            if project_root == nil then
              if fname:match("%.py$") then
                return util.path.dirname(fname)
              end
            end

            return project_root
          end,
        },
      },
    }
  end,
}
