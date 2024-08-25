--- Mason, lspconfig dotenv
return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        auto_install = true,
      })
    end,
  },
  {
    -- refer to './none-ls.lua' for none-ls configuration
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      local servers = {
        bashls = {}, -- Bash language server
        cssls = {}, -- CSS language server
        docker_compose_language_service = {}, -- Docker Compose language server
        dockerls = {}, -- Docker language server
        eslint = {}, -- EsLint language server
        graphql = {}, -- GraphQL language server
        html = {}, -- HTML language server
        jsonls = {}, -- JSON language server
        lua_ls = {}, -- Lua language server
        nginx_language_server = {}, -- Nginx language server
        prismals = {}, -- Prisma language server
        pylsp = {}, -- Python language server
        pyright = {}, -- Python language server
        tailwindcss = {}, -- Tailwind CSS language server
        tsserver = {}, -- TypeScript language server
        typos_lsp = {}, -- Spell check language server
        vtsls = {}, -- Vue language server
        yamlls = {}, -- YAML language server
      }

      for server, config in pairs(servers) do
        lspconfig[server].setup(config)
      end

      local wk = require("which-key")
      wk.register({
        ["<Leader>l"] = {
          name = "LSP",
          a = { vim.lsp.buf.code_action, "Code Action" },
          f = { vim.lsp.buf.format, "Format Buffer" },
          r = { vim.lsp.buf.rename, "Rename" },
          d = { vim.lsp.buf.definition, "Go to Definition" },
          D = { vim.lsp.buf.declaration, "Go to Declaration" },
          i = { vim.lsp.buf.implementation, "Go to Implementation" },
          t = { vim.lsp.buf.type_definition, "Type Definition" },
          h = { vim.lsp.buf.hover, "Hover Documentation" },
          s = { vim.lsp.buf.signature_help, "Signature Help" },
        },

        ["<Leader>bf"] = { vim.lsp.buf.format, "Format Buffer", { mode = "n" } },
        ["K"] = { vim.lsp.buf.hover, "Hover" },
        ["gd"] = { vim.lsp.buf.definition, "Definition" },
        ["[d"] = { vim.diagnostic.goto_prev, "Previous Diagnostic" },
        ["]d"] = { vim.diagnostic.goto_next, "Next Diagnostic" },
      })
    end,
  },
}
