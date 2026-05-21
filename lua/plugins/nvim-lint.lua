-- https://github.com/mfussenegger/nvim-lint
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      go = { "golangcilint" },
      markdown = { "markdownlint" },
      yaml = { "yamllint" },
      nix = { "statix", "deadnix" },
      dockerfile = { "hadolint" },
      terraform = { "tflint" },
    }
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("nvim_lint", { clear = true }),
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
