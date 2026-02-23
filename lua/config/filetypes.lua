-- Custom filetype detection
vim.filetype.add({
  extension = {
    rest = "http",
    sh = "bash",
    ghostty = "config",
    gotmpl = "gotmpl",
    tmpl = "gotmpl",
    templ = "templ",
  },
  filename = {
    [".env"] = "sh",
    ["go.work"] = "gowork",
  },
  pattern = {
    ["Dockerfile.*"] = "dockerfile", -- Treat files starting with Dockerfile as Dockerfile filetype
    ["%.env.*"] = "config"
  },
})
