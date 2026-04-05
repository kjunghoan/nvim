-- Custom filetype detection
vim.filetype.add({
  extension = {
    rest = "http",
    sh = "bash",
    ghostty = "bash",
    gotmpl = "gotmpl",
    tmpl = "gotmpl",
    templ = "templ",
  },
  filename = {
    [".env"] = "sh",
    ["go.work"] = "gowork",
    ["config"] = "bash",
  },
  pattern = {
    ["Dockerfile.*"] = "dockerfile",
    ["%.env.*"] = "config",
  },
})
