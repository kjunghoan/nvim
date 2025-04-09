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

    -- Register the mappings
    wk.register({
      ["<leader>"] = {
        T = { name = "Treesitter" },
        a = { name = "Tab" },
        b = { name = "Buffers" },
        d = { name = "Debug" },
        f = { name = "Find" },
        g = { name = "Git" },
        p = { name = "Plugins" },
        s = { name = "Split" },
        t = { name = "Test" },
        h = { "<cmd>nohlsearch<CR>", "NOHL" },
        q = { "<cmd>confirm q<CR>", "Quit" },
        w = { "<cmd>set wrap!<CR>", "Toggle Wrap" },
      },
      ["<leader>a"] = {
        N = { "<cmd>tabnew %<cr>", "New Tab" },
        h = { "<cmd>-tabmove<cr>", "Move Left" },
        l = { "<cmd>+tabmove<cr>", "Move Right" },
        n = { "<cmd>$tabnew<cr>", "New Empty Tab" },
        o = { "<cmd>tabonly<cr>", "Only" },
      },
      ["<leader>s"] = {
        v = { "<cmd>vsplit<CR>", "Split vertically" },
        h = { "<cmd>split<CR>", "Split Horizontally" },
      },
    })
  end,
}
