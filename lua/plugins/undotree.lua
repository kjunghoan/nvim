return {
  "mbbill/undotree",
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
  },
  init = function()
    -- Persistent undo
    vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
    vim.opt.undofile = true
  end,
  config = function()
    -- Undotree configuration
    vim.g.undotree_WindowLayout = 2 -- Layout with vertical left tree and horizontal diff bottom
    vim.g.undotree_ShortIndicators = 1 -- Use short indicators
    vim.g.undotree_SplitWidth = 30 -- Set tree window width
    vim.g.undotree_DiffpanelHeight = 10 -- Set diff window height
    vim.g.undotree_SetFocusWhenToggle = 1 -- Focus undotree when opening it
  end,
}
