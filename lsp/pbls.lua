-- lsp/pbls.lua
return {
  cmd = { "pbls" },
  filetypes = { "proto" },
  root_markers = {
    "buf.yaml",
    "buf.gen.yaml",
    "buf.work.yaml",
    ".git",
  },
  settings = {},
  single_file_support = true,
  on_attach = function(client, bufnr)
    -- Disable LSP formatting since pbls doesn't support it
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    -- Override the LSP format keymap to use buf instead
    vim.keymap.set('n', '<leader>lf', function()
      local filename = vim.api.nvim_buf_get_name(bufnr)
      if filename == "" then
        vim.notify("Cannot format: buffer has no filename", vim.log.levels.WARN)
        return
      end

      local cmd = "buf format -w " .. vim.fn.shellescape(filename)
      local result = vim.fn.system(cmd)

      if vim.v.shell_error == 0 then
        -- Reload the buffer to show formatting changes
        vim.cmd('checktime')
        vim.notify("Formatted with buf", vim.log.levels.INFO)
      else
        vim.notify("buf format failed: " .. result, vim.log.levels.ERROR)
      end
    end, { buffer = bufnr, desc = "Format Proto with buf" })

    print("pbls attached to buffer: " .. bufnr .. " with buf formatting")
  end,
}
