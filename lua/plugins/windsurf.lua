-- https://github.com/Exafunction/windsurf.nvim
return {
  "Exafunction/windsurf.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Codeium",
  event = "InsertEnter",
  config = function()
    require("codeium").setup({
      enable_cmp_source = false,
      enable_chat = false,
      virtual_text = {
        enabled = true,
        manual = false,
        filetypes = {
          gitcommit = false,
          gitrebase = false,
          cvs = false,
          oil = false,
        },
        default_filetype_enabled = true,
        key_bindings = {
          accept = "<C-M-l>",
          accept_line = "<C-M-L>",
          accept_word = false,
          clear = "<C-]>",
          next = "<M-j>",
          prev = "<M-k>",
        },
      },
    })

    vim.keymap.set(
      "n",
      "<leader>ct",
      "<cmd>Codeium Toggle<cr>",
      { noremap = true, silent = true, desc = "Toggle AI assist" }
    )
  end,
}
