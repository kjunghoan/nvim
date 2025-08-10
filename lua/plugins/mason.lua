return {
  "williamboman/mason.nvim",
  cmd = "Mason",
  event = "BufReadPre",
  config = function()
    require("mason").setup({
      ensure_installed = {
        -- Debuggers
        "debugpy",            -- Python
        "java-debug-adapter", -- Java
      },
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
