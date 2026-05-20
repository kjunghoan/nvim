-- https://github.com/Saghen/blink.cmp
return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      version = "2.*",
      dependencies = {
        "rafamadriz/friendly-snippets",
        "budimanjojo/k8s-snippets",
      },
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    "Exafunction/windsurf.nvim",
  },
  config = function()
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
          "codeium",
        },
        providers = {
          codeium = { name = "Codeium", module = "codeium.blink", async = true },
        },
      },
    })
  end,
}
