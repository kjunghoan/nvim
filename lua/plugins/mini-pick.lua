-- https://github.com/nvim-mini/mini.pick
return {
  "nvim-mini/mini.pick",
  version = false,
  config = function()
    require("mini.pick").setup()

    -- Plugin-specific keymaps
    vim.keymap.set("n", "<leader>ff", function()
      require("mini.pick").builtin.files()
    end, { noremap = true, silent = true, desc = "Find Files" })

    vim.keymap.set("n", "<leader>ft", function()
      require("mini.pick").builtin.grep_live()
    end, { noremap = true, silent = true, desc = "Live Grep" })
  end,
}
