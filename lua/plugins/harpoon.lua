return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",  -- Using Harpoon 2
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    local wk = require("which-key")
    wk.add({
      { "<leader>h", group = "Harpoon" },
      { "<leader>ha", function() harpoon:list():add() end, desc = "Add File" },
      { "<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Toggle Menu" },
      { "<leader>h1", function() harpoon:list():select(1) end, desc = "File 1" },
      { "<leader>h2", function() harpoon:list():select(2) end, desc = "File 2" },
      { "<leader>h3", function() harpoon:list():select(3) end, desc = "File 3" },
      { "<leader>h4", function() harpoon:list():select(4) end, desc = "File 4" },
    })

    -- Additional navigation keymaps if you want them
    vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
  end,
}
