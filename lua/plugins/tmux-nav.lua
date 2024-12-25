return {
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      local nvim_tmux = require("nvim-tmux-navigation")

      nvim_tmux.setup({
        disable_when_zoomed = true,
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
        },
        -- Set the tmux prefix
        tmux_prefix = "<C-s>",
      })

      -- Register keybindings with which-key
      local wk = require("which-key")
      wk.add({
        {
          "<C-h>",
          function()
            require("nvim-tmux-navigation").NvimTmuxNavigateLeft()
          end,
          desc = "Navigate Left",
        },
        {
          "<C-j>",
          function()
            require("nvim-tmux-navigation").NvimTmuxNavigateDown()
          end,
          desc = "Navigate Down",
        },
        {
          "<C-k>",
          function()
            require("nvim-tmux-navigation").NvimTmuxNavigateUp()
          end,
          desc = "Navigate Up",
        },
        {
          "<C-l>",
          function()
            require("nvim-tmux-navigation").NvimTmuxNavigateRight()
          end,
          desc = "Navigate Right",
        },
      })
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
        open_mapping = [[<C-\>]],
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
        },
      })

      -- Lazygit terminal setup
      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = "float",
      })

      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end

      -- Terminal keybindings
      local wk = require("which-key")
      wk.add({ -- TODO wk spec
        { "<leader>t", group = "Terminal" },
        {
          "<leader>tg",
          function()
            _LAZYGIT_TOGGLE()
          end,
          desc = "Lazygit",
        },
        { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float" },
        { "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal" },
        { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical" },
      })
    end,
  },
}
