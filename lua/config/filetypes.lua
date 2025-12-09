-- Custom filetype detection
vim.filetype.add({
  extension = {
    rest = "http",
    sh = "bash",
    ghostty = "config",
  },
  pattern = {
    ["Dockerfile.*"] = "dockerfile", -- Treat files starting with Dockerfile as Dockerfile filetype
  },
})
