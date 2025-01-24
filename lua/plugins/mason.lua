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
        "lua_ls", -- for lua support
        "ts_ls", -- for typescript support
        "pyright", -- for python support
        "gopls", -- for go support
        "jdtls", -- for java support
        "ruff", -- for ruby support
      },
      automatic_installation = true,
    },
    event = "BufReadPre",
    dependencies = "williamboman/mason.nvim",
  },
}
