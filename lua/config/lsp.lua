vim.lsp.config("*", {
  root_markers = { ".git" },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local opts = { buffer = bufnr, noremap = true, silent = true }

    -- Go to definition
    vim.keymap.set(
      "n",
      "gd",
      vim.lsp.buf.definition,
      vim.tbl_extend("force", opts, { desc = "Go to definition" })
    )

    -- Go to declaration
    vim.keymap.set(
      "n",
      "gD",
      vim.lsp.buf.declaration,
      vim.tbl_extend("force", opts, { desc = "Go to declaration" })
    )

    -- Signature help in insert mode
    -- Note: <C-S> is the default, but conflicts with tmux prefix
    vim.keymap.set(
      "i",
      "<C-k>",
      vim.lsp.buf.signature_help,
      vim.tbl_extend("force", opts, { desc = "Signature help" })
    )

    vim.keymap.set(
      "n",
      "<leader>ld",
      vim.diagnostic.open_float,
      vim.tbl_extend("force", opts, { desc = "Show diagnostic" })
    )
    vim.keymap.set(
      "n",
      "<leader>q",
      vim.diagnostic.setloclist,
      vim.tbl_extend("force", opts, { desc = "Diagnostic list" })
    )
  end,
})

vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.HINT] = "⚑",
      [vim.diagnostic.severity.INFO] = "»",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
})

local lsp_configs = {
  "ts_ls",
  "pyright",
  "gopls",
  "lua_ls",
  "jdtls",
  "yamlls",
  "bashls",
  "tofu_ls",
  "ruby_lsp",
  "ltex",
}
for _, server in ipairs(lsp_configs) do
  local ok, config = pcall(require, "lsp." .. server)
  if ok then
    vim.lsp.config(server, config)
  end
end
