-- https://github.com/vuejs/language-tools
return {
  cmd = { "vue-language-server", "--stdio" },
  filetypes = { "vue" },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
}
