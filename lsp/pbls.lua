return {
  cmd = { "pbls" },
  filetypes = { "proto" },
  root_markers = { "buf.yaml", "buf.gen.yaml", "buf.work.yaml", ".git" },
  single_file_support = true,
  on_attach = function(_, bufnr)
    -- Override format to use buf command
    vim.keymap.set('n', '<leader>lf', function()
      vim.cmd('!buf format -w %')
    end, { buffer = bufnr, desc = "Format Proto with buf" })
  end,
}
