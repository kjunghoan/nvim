-- https://github.com/supabase-community/postgres-language-server
-- Postgres-aware SQL language server
return {
  cmd = { "postgres-language-server", "lsp-proxy" },
  filetypes = { "sql" },
  root_markers = { "postgrestools.jsonc", ".git" },
}
