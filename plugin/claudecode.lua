-- https://github.com/coder/claudecode.nvim
vim.pack.add({
  "https://github.com/folke/snacks.nvim",
  "https://github.com/coder/claudecode.nvim",
})

require("claudecode").setup({
  terminal = {
    provider = "snacks",
  },
})

vim.keymap.set("n", "<leader>cc", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude" })
vim.keymap.set("n", "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude" })
vim.keymap.set(
  "n",
  "<leader>cr",
  "<cmd>ClaudeCode --resume<cr>",
  { desc = "Resume Claude" }
)
vim.keymap.set(
  "n",
  "<leader>cC",
  "<cmd>ClaudeCode --continue<cr>",
  { desc = "Continue Claude" }
)
vim.keymap.set(
  "n",
  "<leader>cm",
  "<cmd>ClaudeCodeSelectModel<cr>",
  { desc = "Select Claude model" }
)
vim.keymap.set(
  "n",
  "<leader>cb",
  "<cmd>ClaudeCodeAdd %<cr>",
  { desc = "Add current buffer" }
)
vim.keymap.set("v", "<leader>cs", "<cmd>ClaudeCodeSend<cr>", { desc = "Send to Claude" })
vim.keymap.set(
  "n",
  "<leader>ca",
  "<cmd>ClaudeCodeDiffAccept<cr>",
  { desc = "Accept diff" }
)
vim.keymap.set("n", "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny diff" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "oil", "snacks_picker_list" },
  callback = function(event)
    vim.keymap.set(
      "n",
      "<leader>cs",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      { buffer = event.buf, desc = "Add file" }
    )
  end,
})
