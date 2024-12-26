return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    dependencies = {
      "zbirenbaum/copilot-cmp",
    },
    config = function()
      vim.keymap.set("n", "<leader>c", "<Nop>", { silent = true })

      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = true,
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<M-j>",
            accept_word = "<M-w>",
            accept_line = "<M-l>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<M-]>",
          },
        },
        filetypes = {
          markdown = true,
          help = false,
          gitcommit = true,
          gitrebase = false,
        },
      })

      require("copilot_cmp").setup()

      local wk = require("which-key")
      wk.add({
        { "<leader>c", group = "Copilot" },
        { "<leader>ct", "<cmd>Copilot toggle<cr>", desc = "Toggle Copilot" },
        { "<leader>cp", "<cmd>Copilot panel<cr>", desc = "Open Panel" },
        { "<leader>cs", "<cmd>Copilot status<cr>", desc = "Check Status" },
      })
    end,
  },
}
