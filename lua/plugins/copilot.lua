-- https://github.com/github/copilot.vim
return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    -- Basic settings
    vim.g.copilot_no_tab_map = true -- Disable tab mapping
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ""

    -- Key mappings (customize as needed)
    vim.keymap.set("i", "<C-M-l>", 'copilot#Accept("<CR>")', {
      expr = true,
      silent = true,
      replace_keycodes = false
    })
    vim.keymap.set("i", "<M-j>", '<Plug>(copilot-next)', {})
    vim.keymap.set("i", "<M-k>", '<Plug>(copilot-previous)', {})


    -- Use which-key for documentation if available
    local wk = require("which-key")
    wk.add({
      { "<leader>c",  group = "Copilot" },
      { "<leader>ce", "<cmd>Copilot enable<cr>",  desc = "Enable Copilot" },
      { "<leader>cd", "<cmd>Copilot disable<cr>", desc = "Disable Copilot" },
      { "<leader>cs", "<cmd>Copilot status<cr>",  desc = "Copilot Status" },
    })
  end,
}
