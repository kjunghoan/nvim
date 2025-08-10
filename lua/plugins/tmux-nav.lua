-- https://github.com/alexghergh/nvim-tmux-navigation
return {
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
      tmux_prefix = "<C-s>",
    })
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
}
