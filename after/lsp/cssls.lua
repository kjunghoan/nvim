local ignore_unknown_at_rules = { lint = { unknownAtRules = "ignore" } }

return {
  settings = {
    css = ignore_unknown_at_rules,
    scss = ignore_unknown_at_rules,
    less = ignore_unknown_at_rules,
  },
}
