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

      -- Register base LSP keymaps
      local wk = require("which-key")
      wk.register({ -- TODO: change to newer which-key spec
        l = {
          name = "LSP",
          f = {
            function()
              vim.lsp.buf.format()
            end,
            "Format",
          },
          a = {
            function()
              vim.lsp.buf.code_action()
            end,
            "Code Action",
          },
          r = {
            function()
              vim.lsp.buf.rename()
            end,
            "Rename",
          },
          s = {
            function()
              vim.lsp.buf.signature_help()
            end,
            "Signature Help",
          },
          d = {
            function()
              vim.lsp.buf.definition()
            end,
            "Go to Definition",
          },
          t = {
            function()
              vim.lsp.buf.type_definition()
            end,
            "Type Definition",
          },
          h = {
            function()
              vim.lsp.buf.hover()
            end,
            "Hover",
          },
          i = {
            function()
              vim.lsp.buf.implementation()
            end,
            "Implementation",
          },
          l = {
            function()
              vim.diagnostic.open_float()
            end,
            "Line Diagnostics",
          },
        },
      }, { prefix = "<leader>" })

      -- Diagnostic keymaps
      wk.register({ -- TODO: change to newer which-key spec
        ["[d"] = {
          function()
            vim.diagnostic.goto_prev()
          end,
          "Previous Diagnostic",
        },
        ["]d"] = {
          function()
            vim.diagnostic.goto_next()
          end,
          "Next Diagnostic",
        },
      })

      -- LSP selector function
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

      -- Register LSP selector
      wk.register({ -- TODO: change to newer which-key spec
        l = {
          s = {
            name = "LSP Select",
            s = {
              function()
                select_lsp_server()
              end,
              "Select LSP Server",
            },
          },
        },
      }, { prefix = "<leader>" })
    end,
  },
}
