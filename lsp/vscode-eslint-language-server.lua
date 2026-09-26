-- https://github.com/hrsh7th/vscode-langservers-extracted
-- ESLint language server (lint diagnostics + fixes for js/ts/vue)
local eslint_config_files = {
  ".eslintrc",
  ".eslintrc.js",
  ".eslintrc.cjs",
  ".eslintrc.yaml",
  ".eslintrc.yml",
  ".eslintrc.json",
  "eslint.config.js",
  "eslint.config.mjs",
  "eslint.config.cjs",
  "eslint.config.ts",
  "eslint.config.mts",
  "eslint.config.cts",
}

return {
  cmd = function(dispatchers, config)
    local cmd = "vscode-eslint-language-server"
    if config.root_dir then
      local project_local_cmd = vim.fs.joinpath(config.root_dir, "node_modules/.bin", cmd)
      if vim.fn.executable(project_local_cmd) == 1 then
        cmd = project_local_cmd
      end
    end
    return vim.lsp.rpc.start({ cmd, "--stdio" }, dispatchers)
  end,
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
  },
  workspace_required = true,
  root_dir = function(bufnr, on_dir)
    local project_root = vim.fs.root(bufnr, {
      { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" },
      { ".git" },
    }) or vim.fn.getcwd()
    local buffer_has_eslint_config = vim.fs.find(eslint_config_files, {
      path = vim.api.nvim_buf_get_name(bufnr),
      type = "file",
      limit = 1,
      upward = true,
      stop = vim.fs.dirname(project_root),
    })[1]
    if buffer_has_eslint_config then
      on_dir(project_root)
    end
  end,
  settings = {
    validate = "on",
    useESLintClass = false,
    codeActionOnSave = { enable = false, mode = "all" },
    format = false,
    quiet = false,
    onIgnoredFiles = "off",
    rulesCustomizations = {},
    run = "onType",
    problems = { shortenToSingleLine = false },
    nodePath = "",
    workingDirectory = { mode = "location" },
    codeAction = {
      disableRuleComment = { enable = true, location = "separateLine" },
      showDocumentation = { enable = true },
    },
  },
  -- the server resolves the eslint module relative to settings.workspaceFolder;
  -- without this it errors on textDocument/diagnostic ("path ... undefined")
  before_init = function(_, config)
    local root = config.root_dir or vim.fn.getcwd()
    config.settings = config.settings or {}
    config.settings.workspaceFolder = {
      uri = vim.uri_from_fname(root),
      name = vim.fn.fnamemodify(root, ":t"),
    }
  end,
  handlers = {
    ["eslint/openDoc"] = function(_, result)
      if result then
        vim.ui.open(result.url)
      end
      return {}
    end,
    ["eslint/confirmESLintExecution"] = function(_, result)
      if not result then
        return
      end
      return 4
    end,
    ["eslint/probeFailed"] = function()
      vim.notify("ESLint probe failed.", vim.log.levels.WARN)
      return {}
    end,
    ["eslint/noLibrary"] = function()
      vim.notify("Unable to find ESLint library.", vim.log.levels.WARN)
      return {}
    end,
  },
}
