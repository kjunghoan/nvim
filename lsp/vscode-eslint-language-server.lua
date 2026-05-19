-- https://github.com/hrsh7th/vscode-langservers-extracted
-- ESLint language server (lint diagnostics + fixes for js/ts/vue)
return {
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
  },
  root_markers = {
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.json",
    ".eslintrc.yaml",
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.cjs",
    "eslint.config.ts",
    "package.json",
    ".git",
  },
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
  before_init = function(params, config)
    local root
    if params.workspaceFolders and params.workspaceFolders[1] then
      root = vim.uri_to_fname(params.workspaceFolders[1].uri)
    elseif params.rootPath then
      root = params.rootPath
    else
      root = vim.fn.getcwd()
    end
    config.settings = config.settings or {}
    config.settings.workspaceFolder = {
      uri = vim.uri_from_fname(root),
      name = vim.fn.fnamemodify(root, ":t"),
    }
  end,
}
