-- https://github.com/lewis6991/gitsigns.nvim
return {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  cmd = "Gitsigns",
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false, -- Enable by default
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

    -- Keymaps
    local gs = require("gitsigns")
    vim.keymap.set("n", "<leader>gj", function()
      gs.next_hunk({ navigation_message = false })
    end, { desc = "Next Hunk" })
    vim.keymap.set("n", "<leader>gk", function()
      gs.prev_hunk({ navigation_message = false })
    end, { desc = "Prev Hunk" })
    vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { desc = "Preview Hunk" })
    vim.keymap.set("n", "<leader>gr", gs.reset_hunk, { desc = "Reset Hunk" })
    vim.keymap.set(
      "n",
      "<leader>gl",
      gs.toggle_current_line_blame,
      { desc = "Toggle Blame" }
    )
    vim.keymap.set("n", "<leader>gR", gs.reset_buffer, { desc = "Reset Buffer" })
    vim.keymap.set("n", "<leader>gs", gs.stage_hunk, { desc = "Stage Hunk" })
    vim.keymap.set("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
    vim.keymap.set(
      "n",
      "<leader>gd",
      "<cmd>Gitsigns diffthis HEAD<CR>",
      { desc = "Git Diff" }
    )
  end,
}
