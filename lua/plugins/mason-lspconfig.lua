-- https://github.com/williamboman/mason-lspconfig.nvim
return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason-lspconfig").setup({
      -- Automatically install these LSP servers
      -- Uses LSP server names, not Mason package names
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "pyright",
        "gopls",
        "jdtls",
        "yamlls",
        "ruby_lsp",
        "bashls",
        "jsonls",
        "pbls",
      },
      -- Auto-enable installed servers (this replaces vim.lsp.enable)
      handlers = {
        -- Default handler - auto-setup all servers
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      },
    })
  end,
}
