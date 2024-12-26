return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "ts_ls",
          "gopls",
          "jdtls",
        },
        automatic_installation = true,
      })

      -- LSP selector function (define before we use it)
      local function select_lsp_server()
        local servers = require("mason-lspconfig").get_installed_servers()
        local current_ft = vim.bo.filetype
        local compatible_servers = {}

        for _, server in ipairs(servers) do
          local config = require("lspconfig")[server]
          if config.document_config and config.document_config.default_config.filetypes then
            for _, ft in ipairs(config.document_config.default_config.filetypes) do
              if ft == current_ft then
                table.insert(compatible_servers, server)
                break
              end
            end
          end
        end

        vim.ui.select(compatible_servers, {
          prompt = "Select LSP server:",
          format_item = function(item)
            return item
          end,
        }, function(choice)
          if choice then
            local active_clients = vim.lsp.get_active_clients({ bufnr = 0 })
            for _, client in ipairs(active_clients) do
              vim.lsp.stop_client(client.id)
            end
            require("lspconfig")[choice].setup({})
            vim.cmd("LspStart " .. choice)
          end
        end)
      end

      -- Set up which-key mappings
      local wk = require("which-key")
      wk.add({
        { "<leader>l", group = "LSP" },
        -- LSP keymaps
        { "<leader>lf", function() vim.lsp.buf.format() end, desc = "Format" },
        { "<leader>la", function() vim.lsp.buf.code_action() end, desc = "Code Action" },
        { "<leader>lr", function() vim.lsp.buf.rename() end, desc = "Rename" },
        { "<leader>ls", group = "LSP Select" },
        { "<leader>lss", function() select_lsp_server() end, desc = "Select LSP Server" },
        { "<leader>ld", function() vim.lsp.buf.definition() end, desc = "Go to Definition" },
        { "<leader>lt", function() vim.lsp.buf.type_definition() end, desc = "Type Definition" },
        { "<leader>lh", function() vim.lsp.buf.hover() end, desc = "Hover" },
        { "<leader>li", function() vim.lsp.buf.implementation() end, desc = "Implementation" },
        { "<leader>ll", function() vim.diagnostic.open_float() end, desc = "Line Diagnostics" },
        -- Diagnostic keymaps
        { "[d", function() vim.diagnostic.goto_prev() end, desc = "Previous Diagnostic" },
        { "]d", function() vim.diagnostic.goto_next() end, desc = "Next Diagnostic" },
        -- Language Specific
        { "<leader>ly", group = "Language Specific" },
        { "<leader>lyt", group = "TypeScript" },
        { "<leader>lyj", group = "Java" },
      })
    end,
  },
}