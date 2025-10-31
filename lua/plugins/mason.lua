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
    })
  end,
}
