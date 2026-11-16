vim.pack.add({ "https://github.com/folke/which-key.nvim" })
require("which-key").setup({})

require("which-key").add({
  -- { "<leader>", group = ""},
  { "<leader>c", group = "copilot"},
  { "<leader>f", group = "Find" },
  { "<leader>g", group = "Git" },
  { "<leader>l", group = "LSP" },
  { "<leader>o", group = "Obsidian" },
  { "<leader>p", group = "Oil" },
  { "<leader>q", group = "Trouble" },
  { "<leader>r", group = "Rest" },
  { "<leader>s", group = "Split" },
})
