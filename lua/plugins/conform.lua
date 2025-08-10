return {
  'stevearc/conform.nvim',
  cmd = { "ConformInfo", "Format" },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        -- JavaScript/TypeScript
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },

        -- GraphQL
        graphql = { "prettier" },

        -- Styling
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },

        -- Data formats
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },

        -- Documentation
        markdown = { "prettier" },

        -- Lua
        lua = { "stylua" },

        -- Python (ruff handles this via LSP)
        -- Go (gopls handles this via LSP)
        -- Shell scripts (could add shfmt if needed)
      },

      -- Configure formatters
      formatters = {
        prettier = {
          -- Only run prettier if config file exists
          condition = function(ctx)
            return vim.fs.find({
              ".prettierrc",
              ".prettierrc.json",
              ".prettierrc.yml",
              ".prettierrc.yaml",
              ".prettierrc.js",
              "prettier.config.js",
              "package.json", -- May contain prettier config
            }, { path = ctx.filename, upward = true })[1]
          end,
        },
        stylua = {
          condition = function(ctx)
            return vim.fs.find({ "stylua.toml", ".stylua.toml" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },
    })

    -- Manual format command
    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      require("conform").format({ async = true, lsp_fallback = true, range = range })
    end, { range = true })
  end,
}
