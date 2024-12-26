-- tailwind-tools.lua
return {
  "luckasRanarison/tailwind-tools.nvim",
  name = "tailwind-tools",
  build = ":UpdateRemotePlugins",
  ft = { 
    "css", "scss", "sass", "html", "vue", "svelte", "astro",
    "typescript", "javascript", "typescriptreact", "javascriptreact"
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "telescope.nvim", -- optional
    "nvim-lspconfig", -- optional
  },
  opts = {
    server = {
      filetypes = { 
        "css", "scss", "sass", "html", "vue", "svelte", "astro",
        "typescript", "javascript", "typescriptreact", "javascriptreact"
      },
    },
  },
}
