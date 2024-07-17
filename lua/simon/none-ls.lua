-- local M = {
--   "nvimtools/none-ls.nvim",
--   dependencies = {
--     "nvim-lua/plenary.nvim"
--   }
-- }
--
-- function M.config()
--   local null_ls = require "null-ls"
--
--   local formatting = null_ls.builtins.formatting
--   local diagnostics =  null_ls.builtins.diagnostics
--
--   null_ls.setup {
--     debug = false,
--     sources = {
--       formatting.stylua, -- lua formatter
--       -- formatting.prettier,
--       formatting.black, -- python formatter 
--       -- formatting.prettier.with {
--       --   extra_filetypes = { "toml" },
--       --   -- extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
--       -- },
--       -- formatting.eslint,
--       null_ls.builtins.formatting.biome, -- js formatter and linter
--       null_ls.builtins.completion.spell,
--     },
--   }
-- end
--
-- return M
return {
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    opts = function(_, opts)
      local nls = require("null-ls")
      local formatting = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics
      opts.sources = opts.sources or {}
      vim.list_extend(opts.sources, {
        formatting.prettierd,
        formatting.stylua, -- lua formatter
        formatting.black, -- python formatter
        null_ls.builtins.formatting.biome, -- js formatter and linter
        null_ls.builtins.completion.spell,
      })
      -- table.insert(opts.sources, nls.builtins.formatting.prettierd)
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ["javascript"] = { "prettierd" },
        ["javascriptreact"] = { "prettierd" },
        ["typescript"] = { "prettierd" },
        ["typescriptreact"] = { "prettierd" },
        ["vue"] = { "prettierd" },
        ["css"] = { "prettierd" },
        ["scss"] = { "prettierd" },
        ["less"] = { "prettierd" },
        ["html"] = { "prettierd" },
        ["json"] = { "prettierd" },
        ["jsonc"] = { "prettierd" },
        ["yaml"] = { "prettierd" },
        ["markdown"] = { "prettierd" },
        ["markdown.mdx"] = { "prettierd" },
        ["graphql"] = { "prettierd" },
        ["handlebars"] = { "prettierd" },
      },
    },
  },
}
