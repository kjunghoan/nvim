-- https://github.com/zbirenbaum/copilot.lua
return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>",
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
          accept = "<C-M-l>",
          accept_word = false,
          accept_line = false,
          next = "<M-j>",
          prev = "<M-k>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        gitcommit = false,
        gitrebase = false,
        cvs = false,
      },
      copilot_node_command = "node",
      server_opts_overrides = {},
    })

    -- Keymaps for toggling copilot
    vim.keymap.set(
      "n",
      "<leader>ce",
      "<cmd>Copilot enable<cr>",
      { noremap = true, silent = true, desc = "Enable Copilot" }
    )
    vim.keymap.set(
      "n",
      "<leader>cd",
      "<cmd>Copilot disable<cr>",
      { noremap = true, silent = true, desc = "Disable Copilot" }
    )
    vim.keymap.set(
      "n",
      "<leader>cs",
      "<cmd>Copilot status<cr>",
      { noremap = true, silent = true, desc = "Copilot Status" }
    )
  end,
}
