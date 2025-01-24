return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
      },
    })

    -- Lazygit terminal setup
    local Terminal = require("toggleterm.terminal").Terminal
    -- Terminal keybindings
    local wk = require("which-key")
    wk.add({ -- TODO wk spec
      { "<leader>;", group = "Terminal" },
      { "<leader>;;", "<cmd>tabnew | terminal<CR>", desc = "Term" },
      { "<leader>;f", "<cmd>ToggleTerm direction=float<cr>", desc = "Float" },
      { "<leader>;h", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal" },
      { "<leader>;v", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical" },
    })
  end,
}
