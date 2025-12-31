-- https://github.com/mason-org/mason-lspconfig.nvim
return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
  opts = {
    ensure_installed = {
      "lua_ls",
      "ts_ls",
      "pyright",
      "gopls",
      "jdtls",
      "yamlls",
      "bashls",
      "jsonls",
    },
  },
}
