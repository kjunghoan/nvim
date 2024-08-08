--- Mason, lspconfig dotenv
return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        auto_install = true,
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({}) -- Lua
      lspconfig.tsserver.setup({}) -- TypeScript
      lspconfig.bashls.setup({}) -- Bash
      lspconfig.jsonls.setup({}) -- JSON
      lspconfig.yamlls.setup({}) -- YAML
      lspconfig.dockerls.setup({}) -- Docker
      lspconfig.prismals.setup({}) -- Prisma
      local wk = require("which-key")
      wk.register {
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
