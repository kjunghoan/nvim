-- https://github.com/lewis6991/gitsigns.nvim
return {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  cmd = "Gitsigns",
  config = function()
    local icons = require("icons")

    local wk = require("which-key")
    wk.add({
      { "<leader>g", group = "Git" },
      {
        "<leader>gj",
        function()
          require("gitsigns").next_hunk({ navigation_message = false })
        end,
        desc = "Next Hunk",
      },
      {
        "<leader>gk",
        function()
          require("gitsigns").prev_hunk({ navigation_message = false })
        end,
        desc = "Prev Hunk",
      },
      {
        "<leader>gp",
        function()
          require("gitsigns").preview_hunk()
        end,
        desc = "Preview Hunk",
      },
      {
        "<leader>gr",
        function()
          require("gitsigns").reset_hunk()
        end,
        desc = "Reset Hunk",
      },
      {
        "<leader>gl",
        function()
          require("gitsigns").toggle_current_line_blame()
        end,
        desc = "Toggle Blame",
      },
      {
        "<leader>gR",
        function()
          require("gitsigns").reset_buffer()
        end,
        desc = "Reset Buffer",
      },
      {
        "<leader>gs",
        function()
          require("gitsigns").stage_hunk()
        end,
        desc = "Stage Hunk",
      },
      {
        "<leader>gu",
        function()
          require("gitsigns").undo_stage_hunk()
        end,
        desc = "Undo Stage Hunk",
      },
      {
        "<leader>gd",
        function()
          vim.cmd("Gitsigns diffthis HEAD")
        end,
        desc = "Git Diff",
      },
    })
    require("gitsigns").setup({
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
    })
  end,
}
