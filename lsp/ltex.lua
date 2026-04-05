-- LTeX Plus language server configuration
-- Grammar/spell checker using LanguageTool
local dict_path = vim.fn.expand("~/.config/nvim/spell/ltex.dictionary.en-US.txt")
local dictionary = {}

-- Load external dictionary file if it exists
if vim.fn.filereadable(dict_path) == 1 then
  local words = {}
  for line in io.lines(dict_path) do
    local trimmed = line:match("^%s*(.-)%s*$")
    if trimmed ~= "" and not vim.tbl_contains(words, trimmed) then
      table.insert(words, trimmed)
    end
  end
  dictionary["en-US"] = words
end

return {
  filetypes = {
    "bib",
    "gitcommit",
    "markdown",
    "org",
    "plaintex",
    "rst",
    "rnoweb",
    "tex",
    "pandoc",
    "quarto",
    "rmd",
    "context",
    "html",
    "xhtml",
    "mail",
    "text",
    "changelog",
  },
  root_markers = { ".git" },
  settings = {
    ltex = {
      language = "en-US",
      diagnosticSeverity = "information",
      sentenceCacheSize = 2000,
      additionalRules = {
        enablePickyRules = false,
        motherTongue = "",
      },
      disabledRules = {},
      hiddenFalsePositives = {},
      dictionary = dictionary,
      checkFrequency = "save",
    },
  },
}
