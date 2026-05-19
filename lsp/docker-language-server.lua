-- https://github.com/docker/docker-language-server
-- Dockerfile / Compose / Bake language server
return {
  cmd = { "docker-language-server", "start", "--stdio" },
  filetypes = { "dockerfile" },
  root_markers = { ".git" },
}
