-- https://github.com/typescript-language-server/typescript-language-server
local function vue_ts_plugin()
  local bin = vim.fn.exepath("vue-language-server")
  if bin == "" then
    return nil
  end
  -- nix store path carries the version hash; resolve it at load time
  local real = vim.uv.fs_realpath(bin) or bin
  local root = vim.fn.fnamemodify(real, ":h:h")
  local p = root .. "/lib/language-tools/packages/typescript-plugin"
  return vim.fn.isdirectory(p) == 1 and p or nil
end

local config = {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
  },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
}

local plugin_path = vue_ts_plugin()
if plugin_path then
  config.init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = plugin_path,
        languages = { "vue" },
      },
    },
  }
end

return config
