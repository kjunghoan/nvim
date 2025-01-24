return {
  "folke/which-key.nvim",
  event = "VimEnter",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    window = {
      border = "rounded",
      position = "bottom",
      padding = { 1, 1, 1, 1 },
    },
    show_help = false,
    show_keys = false,
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    local mappings = {
      { "<leader>T", group = "Treesitter" },
      { "<leader>a", group = "Tab" },
      { "<leader>aN", "<cmd>tabnew %<cr>", desc = "New Tab" },
      { "<leader>ah", "<cmd>-tabmove<cr>", desc = "Move Left" },
      { "<leader>al", "<cmd>+tabmove<cr>", desc = "Move Right" },
      { "<leader>an", "<cmd>$tabnew<cr>", desc = "New Empty Tab" },
      { "<leader>ao", "<cmd>tabonly<cr>", desc = "Only" },
      { "<leader>b", group = "Buffers" },
      { "<leader>d", group = "Debug" },
      { "<leader>f", group = "Find" },
      { "<leader>g", group = "Git" },
      { "<leader>h", "<cmd>nohlsearch<CR>", desc = "NOHL" },
      { "<leader>p", group = "Plugins" },
      { "<leader>q", "<cmd>confirm q<CR>", desc = "Quit" },
      { "<leader>t", group = "Test" },
      { "<leader>s", group = "Split" },
    }
    wk.add(mappings)
  end,
}
