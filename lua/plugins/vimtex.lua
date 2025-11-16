return {
  "lervag/vimtex",
  ft = { "tex" },
  config = function()
    vim.g.vimtex_view_method = "skim"
    vim.g.vimtex_compiler_latexmk = {
      options = {
        "-pdf",
        "-shell-escape",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
      },
    }

    local map = function(keys, cmd, desc)
      vim.keymap.set("n", keys, cmd, { noremap = true, silent = true, desc = desc })
    end

    map("<leader>Ll", "<cmd>VimtexCompile<cr>", "Compile")
    map("<leader>Lv", "<cmd>VimtexView<cr>", "View PDF")
    map("<leader>Lc", "<cmd>VimtexClean<cr>", "Clean")
    map("<leader>Le", "<cmd>VimtexErrors<cr>", "Errors")
    map("<leader>Lk", "<cmd>VimtexStop<cr>", "Stop")
    map("<leader>Lt", "<cmd>VimtexToc<cr>", "TOC")
  end,
}
