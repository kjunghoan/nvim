-- https://github.com/nvim-mini/mini.diff
return {
  "nvim-mini/mini.diff",
  version = false,
  config = function()
    require("mini.diff").setup({
      view = {
        style = "sign", -- Show diff signs in gutter
        signs = {
          add = "+",
          change = "~",
          delete = "-",
        },
      },
      mappings = {
        -- Disable defaults, we'll use leader mappings instead
        apply = "",
        reset = "",
        textobject = "gh", -- Keep hunk text object for operations like dgh, ygh
        goto_first = "",
        goto_prev = "",
        goto_next = "",
        goto_last = "",
      },
      wrap_goto = true,
    })

    -- Custom <leader>g mappings for git operations
    vim.keymap.set("n", "<leader>gj", function()
      require("mini.diff").goto_hunk("next")
    end, { noremap = true, silent = true, desc = "Next Hunk" })

    vim.keymap.set("n", "<leader>gk", function()
      require("mini.diff").goto_hunk("prev")
    end, { noremap = true, silent = true, desc = "Prev Hunk" })

    vim.keymap.set("n", "<leader>gp", function()
      require("mini.diff").toggle_overlay()
    end, { noremap = true, silent = true, desc = "Preview Hunk" })

    vim.keymap.set("n", "<leader>ga", function()
      require("mini.diff").apply("cursor")
    end, { noremap = true, silent = true, desc = "Apply Hunk" })

    vim.keymap.set("n", "<leader>gr", function()
      require("mini.diff").reset("cursor")
    end, { noremap = true, silent = true, desc = "Reset Hunk" })
  end,
}
