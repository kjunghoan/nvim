-- disable temporarily to see what is through obsidian.nvim
return {
  cmd = { "markdown-oxide", "--stdio" },
  filetypes = { "markdown" },
  root_markers = {
    ".git",
    "README.md",
  },
  settings = {
    markdown = {
      lint = {
        enable = true,
        lintOnSave = true,
        lintOnChange = true,
        lintOnInsertLeave = true,
      },
      format = {
        enable = true,
        formatOnSave = false,
        formatOnChange = false,
        formatOnInsertLeave = false,
      },
    },
  },
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = function(_, bufnr)
    -- Keep code lens refresh
    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      buffer = bufnr,
      callback = function()
        if vim.lsp.codelens then
          vim.lsp.codelens.refresh()
        end
      end
    })
  end,
  single_file_support = true,
}
