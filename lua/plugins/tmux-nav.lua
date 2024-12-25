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
      wk.register({ -- TODO: wk spec
        ["<C-h>"] = { nvim_tmux.NvimTmuxNavigateLeft, "Navigate Left" },
        ["<C-j>"] = { nvim_tmux.NvimTmuxNavigateDown, "Navigate Down" },
        ["<C-k>"] = { nvim_tmux.NvimTmuxNavigateUp, "Navigate Up" },
        ["<C-l>"] = { nvim_tmux.NvimTmuxNavigateRight, "Navigate Right" },
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
      wk.register({ -- TODO wk spec
        ["<leader>t"] = {
          name = "Terminal",
          g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
          f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
          h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
          v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
        },
      })
    end,
  },
}
