return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    ft = { "python" },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      -- Configure pyright (static type checking)
      require("lspconfig").pyright.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
              typeCheckingMode = "basic", -- Can be "off", "basic", or "strict"
            },
          },
        },
      })

      -- Optionally configure ruff (linting & formatting)
      require("lspconfig").ruff_lsp.setup({
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          -- Disable formatting in favor of none-ls
          client.server_capabilities.documentFormattingProvider = false
          on_attach(client, bufnr)
        end,
      })
    end,
  },
}
