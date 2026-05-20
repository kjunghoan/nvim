-- https://github.com/Wansmer/treesj
return {
  "Wansmer/treesj",
  keys = { "gS" },
  config = function()
    require("treesj").setup({ use_default_keymaps = false })
    vim.keymap.set("n", "gS", function()
      require("treesj").toggle()
    end, { noremap = true, silent = true, desc = "Split/Join Toggle" })
  end,
}
