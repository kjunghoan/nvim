-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
return {
  opts = {
    picker = {
      enabled = true,
      ui_select = true,
      matcher = { frecency = true },
      win = {
        input = {
          keys = {
            ["<C-Up>"] = false,
            ["<C-Down>"] = false,
          },
        },
      },
      sources = {
        buffers = {
          win = {
            input = {
              keys = {
                ["<c-x>"] = false,
                ["<c-d>"] = { "bufdelete", mode = { "n", "i" } },
              },
            },
            list = {
              keys = {
                ["dd"] = false,
                ["<c-d>"] = "bufdelete",
              },
            },
          },
        },
      },
    },
  },
  keys = {
    -- Files
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>ft", function() Snacks.picker.grep() end, desc = "Live Grep" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },
    { "<leader>fF", function() Snacks.picker.files({ hidden = true, ignored = true }) end, desc = "Find All Files" },
    -- Buffers
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
  },
}
