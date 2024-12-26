return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      
      -- Tailwind LSP setup
      lspconfig.tailwindcss.setup({
        -- Lower priority than TypeScript
        priority = 90,
        filetypes = { 
          "css", "scss", "sass", "html", "vue", "svelte", "astro",
          "typescript", "javascript", "typescriptreact", "javascriptreact"
        },
        root_dir = lspconfig.util.root_pattern(
          'tailwind.config.js',
          'tailwind.config.ts',
          'postcss.config.js',
          'postcss.config.ts'
        ),
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                "tw`([^`]*)",
                'tw="([^"]*)',
                'tw={"([^"}]*)',
                "tw\\.\\w+`([^`]*)",
                "tw\\(['\"](.*)['\"]\\)",
                "className: '([^']*)'",
                'className: "([^"]*)"',
                'class: "([^"]*)"',
                'class: \'([^\']*)\'',
              },
            },
          },
        },
      })
    end,
  },
} 