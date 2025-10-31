-- OpenTofu language server configuration
return {
  cmd = { "tofu-ls", "serve" },
  filetypes = { "terraform", "tf" },
  root_markers = { ".terraform", ".git" },
}
