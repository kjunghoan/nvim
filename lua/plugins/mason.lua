return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    event = "BufReadPre",
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
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        -- LSPs
        "lua_ls",
        "ts_ls",
        "pyright",
        "gopls",
        "jdtls",
        "ruff"
      },
      automatic_installation = true,
    },
    event = "BufReadPre",
    dependencies = "williamboman/mason.nvim",
  },
}
