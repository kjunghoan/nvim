--- Mason, lspconfig
return {
  {
    "williamboman/mason.nvim",
    config = function ()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function ()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "tsserver",
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.tsserver.setup({})
      local wk = require("which-key")
      wk.register{
        ["<leader>l"] = {
          name = "LSP",
          a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        },
        ["K"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
        ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition" },
      }
    end
  }
}
