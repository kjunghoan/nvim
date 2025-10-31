-- Custom filetype detection
vim.filetype.add({
  extension = {
    rest = "http", -- Treat .rest files as http filetype
    sh = "bash",   -- Treat .sh files as bash filetype
  },
  pattern = {
    ["Dockerfile.*"] = "dockerfile",   -- Treat files starting with Dockerfile as dockerfile filetype
  },
})
