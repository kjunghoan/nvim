-- https://github.com/mason-org/mason.nvim
return {
  "mason-org/mason.nvim",
  cmd = "Mason",
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
      ensure_installed = {
        -- Formatters
        "stylua",
        "prettier",
        "black",
        "gofumpt",
        "google-java-format",
        "shfmt",
        "mdformat",
        "luacheck",

        -- Linters
        "flake8",
        "luacheck",
        "eslint_d",
        "yamllint",
        "markdownlint",
        "golangci-lint",
        "buf",
        "protolint",

        -- Debuggers
        "debugpy",
        "java-debug-adapter",
        "delve",
        "js-debug-adapter",
      },
    })
  end,
}
