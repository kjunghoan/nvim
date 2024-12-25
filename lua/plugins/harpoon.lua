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
    wk.register({ -- TODO wk spec
      h = {
        name = "Harpoon",
        a = { function() harpoon:list():add() end, "Add File" },
        e = { function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, "Toggle Menu" },
        ["1"] = { function() harpoon:list():select(1) end, "File 1" },
        ["2"] = { function() harpoon:list():select(2) end, "File 2" },
        ["3"] = { function() harpoon:list():select(3) end, "File 3" },
        ["4"] = { function() harpoon:list():select(4) end, "File 4" },
      }
    }, { prefix = "<leader>" })

    -- Additional navigation keymaps if you want them
    vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
  end,
}
