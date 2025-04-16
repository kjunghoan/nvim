-- Not being used, refer to plugins/ltex_extra
return {
  cmd = { "ltex-ls" },
  filetypes = { "markdown", "text", "tex", "latex" },
  settings = {
    ltex = {
      language = "en-US",
      diagnosticSeverity = "information",
      additionalRules = {
        enablePickyRules = true,
        motherTongue = "en-US",
      },
      disabledRules = {
        ["en-US"] = { "WHITESPACE_RULE" },
      },
      dictionary = {
        ["en-US"] = {},
      },
      hiddenFalsePositives = {
        ["en-US"] = {},
      },
    },
  },
}
