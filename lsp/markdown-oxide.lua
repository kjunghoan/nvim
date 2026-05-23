-- https://github.com/Feel-ix-343/markdown-oxide
-- PKM-oriented markdown language server (links, daily notes, completion)
return {
  cmd = { "markdown-oxide" },
  filetypes = { "markdown" },
  root_markers = { ".obsidian", ".moxide.toml", ".git" },
}
