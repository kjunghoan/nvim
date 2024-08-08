return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/notes",
      },
    },
    ui = {
      enable = true,
      conceallevel = 1,  -- Ensure conceallevel is set correctly
    },
    prepend_note_id = true,
    new_notes_location = "current_dir",
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
  },
  config = function()
    -- Set conceallevel globally or for markdown files specifically
    vim.cmd("set conceallevel=1")
    vim.cmd([[
      augroup ObsidianMarkdown
        autocmd!
        autocmd FileType markdown setlocal conceallevel=1
      augroup END
    ]])

    -- Custom command to handle image pasting using xclip
    vim.cmd([[
      command! -nargs=0 ObsidianPasteImg lua require('obsidian').paste_image()
    ]])
  end,
}


