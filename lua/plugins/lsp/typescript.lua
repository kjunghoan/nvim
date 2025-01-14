return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  opts = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    return {
      servers = {
        ts_ls = {
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
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false

            local opts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set("n", "<leader>lyt", function()
              vim.lsp.buf.execute_command({
                command = "_typescript.organizeImports",
                arguments = { vim.api.nvim_buf_get_name(0) },
              })
            end, opts)
          end,
        },

        eslint = {
          capabilities = capabilities,
          settings = {
            workingDirectory = { mode = "auto" },
            format = false,
            packageManager = "npm",
            eslint = {
              enable = true,
              validateOnType = true,
            },
          },
          root_dir = require("lspconfig.util").root_pattern(".eslintrc", ".eslintrc.js", ".eslintrc.json", "eslint.config.js"),
        },
      },
    }
    -- TODO: Add deno
  end,
}
