-- https://github.com/stevearc/oil.nvim
return {
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      default_file_explorer = true,
      watch_for_changes = true,
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
      },
      use_default_keymaps = false,
      view_options = {
        show_hidden = true,
      },
      float = {
        max_width = 80,
        max_height = 20,
        border = "rounded",
      },
      preview_win = {
        border = "rounded",
      },
    })

    vim.keymap.set(
      "n",
      "<leader>pv",
      "<cmd>Oil<cr>",
      { noremap = true, silent = true, desc = "Oil Explorer" }
    )
    vim.keymap.set(
      "n",
      "<leader>pf",
      "<cmd>Oil --float<cr>",
      { noremap = true, silent = true, desc = "Oil Float" }
    )
  end,
}
