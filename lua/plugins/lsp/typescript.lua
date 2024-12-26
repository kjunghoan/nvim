return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  opts = function()
    -- Add additional capabilities supported by nvim-cmp
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    return {
      -- Server configurations
      servers = {
        -- TypeScript configuration
        tsserver = {
          capabilities = capabilities,
          filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
          root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
              },
              format = {
                indentSize = 2,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
              },
              format = {
                indentSize = 2,
              },
            },
          },
          on_attach = function(client, bufnr)
            -- Disable formatting from tsserver if using prettier
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false

            -- TypeScript specific keymaps
            local opts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set("n", "<leader>lyt", function()
              vim.lsp.buf.execute_command({
                command = "_typescript.organizeImports",
                arguments = { vim.api.nvim_buf_get_name(0) },
              })
            end, opts)
          end,
        },

        -- ESLint configuration
        eslint = {
          capabilities = capabilities,
          settings = {
            workingDirectory = { mode = "auto" },
            format = false, -- Disable formatting since we're using prettier
            packageManager = "npm",
            eslint = {
              enable = true,
              validateOnType = true,
            },
          },
          root_dir = require("lspconfig.util").root_pattern(
            ".eslintrc",
            ".eslintrc.js",
            ".eslintrc.json"
          ),
        },
      },
    }
  end,
}