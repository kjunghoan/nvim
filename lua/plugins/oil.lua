return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  config = function()
    require("oil").setup({
      default_file_explorer = true,
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
        border = vim.o.winborder or "rounded",
      },
      preview = {
        border = vim.o.winborder or "rounded",
      }
    })

    local wk = require("which-key")
    wk.add({
      { "<leader>p", group = "Project/Plugins" },
      { "<leader>pv", "<cmd>Oil<cr>", desc = "Oil Explorer" },
      { "<leader>pf", "<cmd>Oil --float<cr>", desc = "Oil Float" },
    })
  end,
}
