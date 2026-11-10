-- https://github.com/latex-lsp/texlab
-- LaTeX language server (completion, symbols, folding; no local build)
return {
  cmd = { "texlab" },
  filetypes = { "tex", "plaintex", "bib" },
  root_markers = { ".latexmkrc", ".git" },
}
