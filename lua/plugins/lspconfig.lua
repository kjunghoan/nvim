return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mason.nvim",
  },
  config = function()
    local capabilities = require("config.capabilities")[1]()

    local servers = {
      bashls = {},
      gopls = {},
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
          },
        },
      },
      pyright = {},
      ruff = {},
      ts_ls = {},
      yamlls = {
        settings = {
          yaml = {
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              ["https://json.schemastore.org/docker-compose.yml"] = "docker-compose*.yml",
              ["https://json.schemastore.org/kustomization.json"] = "kustomization.yaml",
            },
          },
        },
      },
      jsonls = {},
      terraformls = {},
      tflint = {},
    }

    for server, config in pairs(servers) do
      config.capabilities = capabilities
      vim.lsp.config[server] = config
      vim.lsp.enable(server)
    end
  end,
}
