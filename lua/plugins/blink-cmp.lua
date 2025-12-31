-- https://github.com/Saghen/blink.cmp
return {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "budimanjojo/k8s-snippets",
  },
  version = "1.*",
  config = function()
    local blink = require("blink.cmp")
    blink.setup({
      keymap = {
        preset = "default",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<M-CR>"] = { "accept", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
      },
      appearance = {
        nerd_font_variant = "normal",
      },
      completion = {
        documentation = { auto_show = true },
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
      },
      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
        },
      },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },
    })
  end,
}
