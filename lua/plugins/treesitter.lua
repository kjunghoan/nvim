-- https://github.com/nvim-treesitter/nvim-treesitter
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = {
        -- Core
        "lua",
        "vim",
        "vimdoc",
        "query",

        -- languages
        "javascript",
        "typescript",
        "tsx",
        "python",
        "go",
        "gomod",
        "gowork",
        "gotmpl",
        "java",

        -- DevOps/Config
        "yaml",
        "json",
        "toml",
        "hcl",
        "dockerfile",
        "proto",

        -- Markup/Web
        "markdown",
        "markdown_inline",
        "html",
        "css",

        -- Utilities
        "bash",
        "make",
        "gitignore",
        "ini",
      },

      -- Auto-install missing parsers
      auto_install = true,

      -- Treesitter-based syntax highlighting
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      -- Treesitter-based indentation
      indent = {
        enable = true,
      },
    })
  end,
}
