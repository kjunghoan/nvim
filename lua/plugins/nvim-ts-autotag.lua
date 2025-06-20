return {
  "windwp/nvim-ts-autotag",
  dependencies = "nvim-treesitter/nvim-treesitter",
  event = "InsertEnter",
  config = function()
    require("nvim-ts-autotag").setup({
      -- Optional: customize specific filetypes
      filetypes = {
        "html", "xml", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte", "vue", "tsx", "jsx",
        "rescript", "markdown", "php", "astro", "handlebars", "hbs", "eruby"
      },
    })
  end,
}
