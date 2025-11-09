-- https://github.com/stevearc/conform.nvim
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre", "VeryLazy" },
  cmd = { "ConformInfo", "Format" },
  keys = {
    { "<leader>lf", "<cmd>Format<cr>", desc = "Format buffer", mode = { "n", "v" } },
  },
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
        markdown = { "mdformat" },

        -- Lua
        lua = { "stylua" },

        -- Python
        python = { "black" },

        -- Shell
        sh = { "shfmt" },
        bash = { "shfmt" },

        -- Go (gopls handles formatting via LSP)
        -- Java (google-java-format via LSP)
      },

      -- Configure formatters
      formatters = {
        prettier = {
          -- Only run prettier if config file exists
          condition = function(_, ctx)
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
          condition = function(_, ctx)
            return vim.fs.find({ "stylua.toml", ".stylua.toml" }, { path = ctx.filename, upward = true })[1]
          end,
        },
      },

      -- Default format options
      default_format_opts = {
        lsp_format = "fallback",
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
      require("conform").format({ async = true, lsp_format = "fallback", range = range })
    end, { range = true })
  end,
}
