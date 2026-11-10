vim.pack.add({
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/budimanjojo/k8s-snippets",
  { src = "https://github.com/L3MON4D3/LuaSnip", version = vim.version.range("2") },
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1") },
})

require("luasnip.loaders.from_vscode").lazy_load()

local sql_sources = { "snippets", "dadbod", "buffer" }

require("blink.cmp").setup({
  snippets = { preset = "luasnip" },
  keymap = {
    preset = "default",
    ["<M-CR>"] = { "accept", "fallback" },
    ["<C-e>"] = { "hide", "fallback" },
    -- reserved globally as the OS/keyboard language changer
    ["<C-space>"] = {},
    ["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
    ["<Tab>"] = { "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },
  },
  signature = { enabled = true },
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
    per_filetype = {
      sql = sql_sources,
      mysql = sql_sources,
      plsql = sql_sources,
    },
    providers = {
      dadbod = {
        name = "Dadbod",
        module = "vim_dadbod_completion.blink",
      },
    },
  },
})
