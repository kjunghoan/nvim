vim.pack.add({ "https://codeberg.org/mfussenegger/nvim-lint" })
local lint = require("lint")
lint.linters_by_ft = {
  go = { "golangcilint" },
  markdown = { "markdownlint" },
  yaml = { "yamllint" },
  nix = { "statix", "deadnix" },
  dockerfile = { "hadolint" },
  terraform = { "tflint" },
}
lint.linters.markdownlint.args = { "--stdin", "--disable", "MD013", "MD033", "MD029" }

local function linter_is_installed(linter)
  local command = type(linter.cmd) == "function" and linter.cmd() or linter.cmd
  return vim.fn.executable(command) == 1
end

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("nvim_lint", { clear = true }),
  callback = function()
    lint.try_lint(nil, { filter = linter_is_installed })
  end,
})
