-- https://github.com/nvim-mini/mini.pick
return {
  "nvim-mini/mini.pick",
  version = false,
  config = function()
    require("mini.pick").setup({
      mappings = {
        choose_in_split = "<M-s>",
        move_down = "<C-j>",
        move_up = "<C-k>",
      }
    })

    -- Plugin-specific keymaps
    vim.keymap.set("n", "<leader>ff", function()
      require("mini.pick").builtin.files()
    end, { noremap = true, silent = true, desc = "Find Files" })

    vim.keymap.set("n", "<leader>ft", function()
      require("mini.pick").builtin.grep_live()
    end, { noremap = true, silent = true, desc = "Live Grep" })

    vim.keymap.set("n", "<leader>fF", function()
      require("mini.pick").builtin.cli({
        command = {
          "fd", "--type", "f", "--no-ignore",
          "--exclude", ".git",
          "--exclude", "node_modules",
          "--exclude", "vendor"
        }
      })
    end, { noremap = true, silent = true, desc = "Find All Files (including gitignored)" })
  end,
}
