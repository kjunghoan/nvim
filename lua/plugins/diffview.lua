-- https://github.com/sindrets/diffview.nvim
return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewFileHistory",
  },
  keys = {
    {
      "<leader>gd",
      function()
        vim.cmd("DiffviewOpen -- " .. vim.fn.fnameescape(vim.fn.expand("%")))
      end,
      desc = "Diffview: current file",
    },
    { "<leader>gD", "<cmd>DiffviewOpen<cr>", desc = "Diffview: whole repo" },
    { "<leader>gL", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview: repo history" },
  },
  config = function()
    require("diffview").setup({})
  end,
}
