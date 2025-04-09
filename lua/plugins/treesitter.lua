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
        -- Enable syntax highlighting
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },

        -- Enable indentation
        indent = { enable = true },

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
            init_selection = "gnn", -- set to `false` to disable one of the mappings
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },

        -- Enable nvim-ts-context-commentstring
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
      })

      -- Add which-key mappings
      local wk = require("which-key")
      wk.add({
        { "<leader>T", group = "Treesitter" },
        { "<leader>Ti", "<cmd>TSInstallInfo<cr>", desc = "Installation Info" },
        { "<leader>Tu", "<cmd>TSUpdate<cr>", desc = "Update Parsers" },
        { "<leader>Tl", ":TSInstall ", desc = "Install Language Parser" },
        { "<leader>Ts", ":TSInstallSync ", desc = "Sync Parsers" },
      })
    end,
  },
}
