return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    ft = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- TypeScript specific keymaps
      local function on_attach(client, bufnr)
        local wk = require("which-key")
        wk.add({
          { "<leader>ts", group = "TypeScript" },
          { "<leader>tsi", "<cmd>TypescriptAddMissingImports<cr>", desc = "Add Missing Imports", buffer = bufnr },
          { "<leader>tso", "<cmd>TypescriptOrganizeImports<cr>", desc = "Organize Imports", buffer = bufnr },
          { "<leader>tsf", "<cmd>TypescriptFixAll<cr>", desc = "Fix All", buffer = bufnr },
          { "<leader>tsr", "<cmd>TypescriptRenameFile<cr>", desc = "Rename File", buffer = bufnr },
        })
      end

      -- Enhanced TypeScript config using ts_ls
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
            suggest = {
              completeFunctionCalls = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      })

      -- Support for Deno
      lspconfig.denols.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
        settings = {
          deno = {
            enable = true,
            suggest = {
              imports = {
                hosts = {
                  ["https://deno.land"] = true,
                  ["https://x.nest.land"] = true,
                  ["https://crux.land"] = true,
                },
              },
            },
          },
        },
      })
    end,
  },
}
