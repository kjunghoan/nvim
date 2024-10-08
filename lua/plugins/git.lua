-- gitsigns, vim-fugitive, lazygit
return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufEnter",
    cmd = "Gitsigns",
    config = function()
      local icons = require "icons"

      local wk = require "which-key"
      wk.register {
        ["<leader>gj"] = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
        ["<leader>gk"] = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
        ["<leader>gp"] = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
        ["<leader>gr"] = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
        ["<leader>gl"] = { "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<cr>", "Blame" },
        ["<leader>gR"] = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
        ["<leader>gs"] = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        ["<leader>gu"] = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
        ["<leader>gd"] = { "<cmd>Gitsigns diffthis HEAD<cr>", "Git Diff" },
      }

      require("gitsigns").setup {
        signs = {
          add = {
            text = icons.ui.BoldLineMiddle,
          },
          change = {
            text = icons.ui.BoldLineDashedMiddle,
          },
          delete = {
            text = icons.ui.TriangleShortArrowRight,
          },
          topdelete = {
            text = icons.ui.TriangleShortArrowRight,
          },
          changedelete = {
            text = icons.ui.BoldLineMiddle,
          },
        },
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        update_debounce = 200,
        max_file_length = 40000,
        preview_config = {
          border = "rounded",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
      }
    end
  },
  {
    "tpope/vim-fugitive"
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  }
}
