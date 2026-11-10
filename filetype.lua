vim.filetype.add({
  filename = {
    [".markdownlintrc"] = "json",
  },
  pattern = {
    [".*%.dev%.vars"] = "env",
  },
})
