-- Vue language server configuration (hybrid mode, v3.0+)
-- Works alongside ts_ls, which loads @vue/typescript-plugin.
return {
  cmd = { "vue-language-server", "--stdio" },
  filetypes = { "vue" },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
}
