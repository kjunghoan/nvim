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
            accept = "<M-S-j>",
            accept_word = "<M-S-w>",
            accept_line = "<M-S-l>",
            next = "<M-S-]>",
            prev = "<M-S-[>",
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
