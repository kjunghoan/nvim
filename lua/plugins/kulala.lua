-- https://github.com/mistweaverco/kulala.nvim
return {
  "mistweaverco/kulala.nvim",
  ft = { "http", "rest" },
  config = function()
    require("kulala").setup({
      -- Display responses in floating window
      display_mode = "float", -- float|split (default: split)
      default_view = "body", -- body|headers|headers_body
      default_env = "dev", -- Default environment
      debug = false,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "http", "rest" },
      callback = function()
        local opts = { buffer = true, noremap = true, silent = true }

        -- Execute requests
        vim.keymap.set(
          "n",
          "<leader>rr",
          "<cmd>lua require('kulala').run()<cr>",
          vim.tbl_extend("force", opts, { desc = "Run request" })
        )
        vim.keymap.set(
          "n",
          "<leader>ra",
          "<cmd>lua require('kulala').run_all()<cr>",
          vim.tbl_extend("force", opts, { desc = "Run all requests" })
        )

        -- Navigation
        vim.keymap.set(
          "n",
          "[r",
          "<cmd>lua require('kulala').jump_prev()<cr>",
          vim.tbl_extend("force", opts, { desc = "Jump to previous request" })
        )
        vim.keymap.set(
          "n",
          "]r",
          "<cmd>lua require('kulala').jump_next()<cr>",
          vim.tbl_extend("force", opts, { desc = "Jump to next request" })
        )

        -- View management
        vim.keymap.set(
          "n",
          "<leader>rt",
          "<cmd>lua require('kulala').toggle_view()<cr>",
          vim.tbl_extend("force", opts, { desc = "Toggle view" })
        )
        vim.keymap.set(
          "n",
          "<leader>ri",
          "<cmd>lua require('kulala').inspect()<cr>",
          vim.tbl_extend("force", opts, { desc = "Inspect request" })
        )

        -- Environment switching
        vim.keymap.set(
          "n",
          "<leader>re",
          "<cmd>lua require('kulala').set_selected_env()<cr>",
          vim.tbl_extend("force", opts, { desc = "Select environment" })
        )
      end,
    })
  end,
}
