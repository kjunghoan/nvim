return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    dependencies = {
      "zbirenbaum/copilot-cmp"
    },
    config = function()
      -- First, map Space-c to do nothing to prevent the default behavior
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

      -- Set up copilot-cmp integration
      require("copilot_cmp").setup()

      -- Add which-key bindings for Copilot after clearing the mapping
      local wk = require("which-key")
      wk.add({
        { "<leader>c", group = "Copilot" },
        { "<leader>ct", "<cmd>Copilot toggle<cr>", desc = "Toggle Copilot" },
        { "<leader>cp", "<cmd>Copilot panel<cr>", desc = "Open Panel" }, -- Added panel command
        { "<leader>cs", "<cmd>Copilot status<cr>", desc = "Check Status" }, -- Added status command
      })
    end,
  },
}