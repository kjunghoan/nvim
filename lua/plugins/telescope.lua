-- https://github.com/nvim-telescope/telescope.nvim
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        lazy = true,
      },
      "nvim-telescope/telescope-project.nvim",
    },
    config = function()
      local actions = require("telescope.actions")

      require("telescope").setup({
        defaults = {
          path_display = { "smart" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
            },
            n = {
              ["q"] = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
            theme = "dropdown",
            previewer = true,
            hidden = true,
          },
          live_grep = {
            theme = "dropdown",
            previewer = true,
          },
          buffers = {
            theme = "dropdown",
            previewer = false,
            initial_mode = "normal",
          },
        },
      })

      require("telescope").load_extension("fzf")
      require("telescope").load_extension("project")

      local wk = require("which-key")
      wk.add({
        { "<leader>f", group = "Find" },
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { "<leader>ft", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
        { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
        { "<leader>fp", "<cmd>Telescope project<cr>", desc = "Projects" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
        { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Find String" },
      })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
