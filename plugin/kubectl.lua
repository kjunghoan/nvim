vim.pack.add({
  "https://github.com/saghen/blink.download",
  {
    src = "https://github.com/Ramilito/kubectl.nvim",
    version = vim.version.range("2"),
  },
})
require("kubectl").setup({ namespace = "All" })

vim.keymap.set("n", "<leader>k", function()
  require("kubectl").toggle()
end, { desc = "Toggle Kubectl" })
