-- nvim-lspconfig for LSP management
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mason.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local capabilities = require("config.capabilities")[1]()

    -- Basic server configurations
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

    -- Setup each server
    for server, config in pairs(servers) do
      config.capabilities = capabilities
      lspconfig[server].setup(config)
    end
  end,
}
