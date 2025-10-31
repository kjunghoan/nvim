-- https://github.com/mbbill/undotree
return {
  "mbbill/undotree",
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
  },
  config = function()
    vim.g.undotree_WindowLayout = 2 -- Changed from default (1)
    vim.g.undotree_ShortIndicators = 1 -- Changed from default (0)
    vim.g.undotree_SetFocusWhenToggle = 1 -- Changed from default (0)
  end,
}
