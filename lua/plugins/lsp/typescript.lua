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
        print("TypeScript LSP attaching to buffer", bufnr)
        print("Client name:", client.name)
        print("Root dir:", client.config.root_dir)
        
        local wk = require("which-key")
        wk.add({
          { "<leader>lyti", function() client.request("_typescript.addMissingImports", { vim.api.nvim_buf_get_name(0) }) end, desc = "Add Missing Imports" },
          { "<leader>lyto", function() client.request("_typescript.organizeImports", { vim.api.nvim_buf_get_name(0) }) end, desc = "Organize Imports" },
          { "<leader>lytf", function() client.request("_typescript.fixAll", { vim.api.nvim_buf_get_name(0) }) end, desc = "Fix All" },
          { "<leader>lytr", function() vim.lsp.buf.rename() end, desc = "Rename" },
        })
        
        print("TypeScript LSP keymaps registered for buffer", bufnr)
      end

      -- Enhanced TypeScript config using typescript-language-server
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
        single_file_support = true,
        priority = 100,  -- Higher priority than other LSPs
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
        init_options = {
          hostInfo = "neovim",
          preferences = {
            importModuleSpecifierPreference = "relative",
          },
        },
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
