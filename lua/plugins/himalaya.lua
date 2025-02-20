return {
  "pimalaya/himalaya-vim",
  config = function()
    -- Set Himalaya options
    vim.g.himalaya_folder_picker = "telescope" -- Use telescope for folder picking
    vim.g.himalaya_folder_picker_telescope_preview = 1 -- Enable folder preview

    -- Set up which-key bindings for Himalaya with <leader>H
    local wk = require("which-key")
    wk.register({
      ["<leader>H"] = { name = "Himalaya" },
      ["<leader>Hm"] = { "<cmd>Himalaya<cr>", "Open Mail Client" },
      ["<leader>Hw"] = { "<plug>(himalaya-email-write)", "Write New Email" },
      ["<leader>Hr"] = { "<plug>(himalaya-email-reply)", "Reply to Email" },
      ["<leader>HR"] = { "<plug>(himalaya-email-reply-all)", "Reply All" },
      ["<leader>Hf"] = { "<plug>(himalaya-email-forward)", "Forward Email" },
      ["<leader>Ha"] = { "<plug>(himalaya-email-add-attachment)", "Add Attachment" },

      -- Account switching shortcuts
      ["<leader>Hs"] = { name = "Switch Account" },
      ["<leader>Hsk"] = { "<cmd>let g:himalaya_account = 'kjh'<CR>", "Switch to Work Account" },
      ["<leader>Hsd"] = { "<cmd>let g:himalaya_account = 'djw'<CR>", "Switch to Personal Account" },
      ["<leader>Hso"] = { "<cmd>let g:himalaya_account = 'omuna'<CR>", "Switch to Server Account" },
      ["<leader>Hsj"] = { "<cmd>let g:himalaya_account = 'jhk'<CR>", "Switch to Backup Work Account" },
    })
  end,
}
