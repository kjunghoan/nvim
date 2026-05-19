-- https://github.com/oxalica/nil
-- Nix language server
return {
  cmd = { "nil" },
  filetypes = { "nix" },
  root_markers = { "flake.nix", ".git" },
}
