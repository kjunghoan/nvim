-- https://github.com/ThePrimeagen/harpoon
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local harpoon = require("harpoon")

    -- Set up harpoon with a basic configuration
    harpoon:setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
        key = function()
          return vim.fn.getcwd()
        end,
      },
    })

    -- Custom function to mark file with notification
    local function mark_file()
      harpoon:list():add()
      vim.notify("󱡅  Marked file", vim.log.levels.INFO)
    end

    -- Set up keymaps
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }

    keymap("n", "<S-m>", mark_file, opts)

    keymap("n", "<TAB>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, opts)

    -- Navigation keymaps
    keymap("n", "<C-S-P>", function()
      harpoon:list():prev()
    end, opts)

    keymap("n", "<C-S-N>", function()
      harpoon:list():next()
    end, opts)
  end,
}
