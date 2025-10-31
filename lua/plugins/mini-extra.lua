-- https://github.com/nvim-mini/mini.extra
return {
  "nvim-mini/mini.extra",
  version = false,
  dependencies = { "nvim-mini/mini.pick" },
  config = function()
    vim.keymap.set("n", "<leader>fr", function()
      require("mini.extra").pickers.oldfiles()
    end, { noremap = true, silent = true, desc = "Recent Files" })
  end,
}
