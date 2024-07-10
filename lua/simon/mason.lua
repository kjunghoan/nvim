local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
}


function M.config()
  local servers = {
    "cssls",
    "lua_ls",
    "html",
    "tsserver",
    "pyright",
    "bashls",
    "jsonls",
    "jdtls",
    "yamlls",


    -- Formatters
    "eslint",
    --"prettierd"
  }

  require("mason").setup {
    ui = {
      border = "rounded",
    },
  }

  require("mason-lspconfig").setup {
    ensure_installed = servers,
  }
end

return M

