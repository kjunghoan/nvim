return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Configure linters by filetype
    lint.linters_by_ft = {
      python = { "flake8" },
      lua = { "luacheck" },
      javascript = { "eslint" },
      typescript = { "eslint" },
      yaml = { "yamllint" },
      markdown = { "markdownlint" },
      go = { "golangcilint" },
      proto = { "buf_lint", "protolint" },
    }

    -- Create autocmd to trigger linting
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
