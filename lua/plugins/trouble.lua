-- https://github.com/folke/trouble.nvim
return {
  "folke/trouble.nvim",
  cmd = "Trouble", -- keep: manual :Trouble + todo-comments' :TodoTrouble
  opts = {
    focus = true, -- jump into the list on open so it's immediately navigable
  },
  keys = {
    { "<leader>q", "<cmd>Trouble<cr>", desc = "Trouble" },
    { "<leader>qq", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
    { "<leader>qb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics (Trouble)" },
    { "<leader>qf", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list (Trouble)" },
    { "<leader>ql", "<cmd>Trouble loclist toggle<cr>", desc = "Location list (Trouble)" },
    { "<leader>qt", "<cmd>Trouble todo toggle<cr>", desc = "Todos (Trouble)" },
  },
}
