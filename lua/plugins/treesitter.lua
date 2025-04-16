-- https://github.com/nvim-treesitter/nvim-treesitter
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/playground",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      -- Import nvim-treesitter plugin
      local treesitter = require("nvim-treesitter.configs")

      -- Configure treesitter
      treesitter.setup({
        -- Enable syntax highlighting (now async by default in 0.11)
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        autotag = { enable = true },

        -- Ensure these language parsers are installed
        ensure_installed = {
          "json",
          "javascript",
          "typescript",
          "tsx",
          "yaml",
          "html",
          "css",
          "java",
          "python",
          "lua",
          -- "go",
          "markdown",
          "markdown_inline",
          "bash",
          "vim",
          "dockerfile",
          "gitignore",
          "query",
          "ini",
          "toml",
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },

        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
      })

      -- Which-key mappings remain the same
      local wk = require("which-key")
      wk.add({
        { "<leader>Ti", "<cmd>TSInstallInfo<cr>", desc = "Installation Info" },
        { "<leader>Tu", "<cmd>TSUpdate<cr>",      desc = "Update Parsers" },
        { "<leader>Tl", ":TSInstall ",            desc = "Install Language Parser" },
        { "<leader>Ts", ":TSInstallSync ",        desc = "Sync Parsers" },
      })
    end,
  },
}
