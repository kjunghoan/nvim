-- https://github.com/folke/which-key.nvim
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
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
    show_help = false,
    show_keys = false,
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- Register the mappings
    wk.add({
      { "<leader>T",  group = "Treesitter" },
      { "<leader>a",  group = "Tab" },
      { "<leader>aN", "<cmd>tabnew %<cr>",   desc = "New Tab" },
      { "<leader>ah", "<cmd>-tabmove<cr>",   desc = "Move Left" },
      { "<leader>al", "<cmd>+tabmove<cr>",   desc = "Move Right" },
      { "<leader>an", "<cmd>$tabnew<cr>",    desc = "New Empty Tab" },
      { "<leader>ao", "<cmd>tabonly<cr>",    desc = "Only" },
      { "<leader>f",  group = "Find" },
      { "<leader>g",  group = "Git" },
      { "<leader>h",  "<cmd>nohlsearch<CR>", desc = "NOHL" },
      { "<leader>p",  group = "Oil" },
      { "<leader>q",  "<cmd>confirm q<CR>",  desc = "Quit" },
      { "<leader>s",  group = "Split" },
      { "<leader>t",  group = "Test" },
    })
  end,
}
