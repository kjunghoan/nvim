-- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
return {
  opts = {
    picker = { enabled = true },
  },
  keys = {
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>ft", function() Snacks.picker.grep() end, desc = "Live Grep" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },
    { "<leader>fF", function() Snacks.picker.files({ hidden = true, ignored = true }) end, desc = "Find All Files" },
  },
}
