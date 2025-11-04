-- Global LSP configuration for Neovim 0.11+
-- Uses built-in vim.lsp instead of nvim-lspconfig

-- Global settings for all LSP servers
vim.lsp.config("*", {
  root_markers = { ".git" },
})

-- LspAttach autocmd for keybindings and per-buffer setup
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf

    -- Neovim 0.11+ provides these by default:
    -- gra  - code actions
    -- grn  - rename
    -- grr  - references
    -- gri  - implementation
    -- grt  - type definition
    -- gO   - document symbols
    -- K    - hover

    -- Don't set formatexpr - let conform handle gq formatting
    -- vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"

    -- Additional keybindings
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

    -- Diagnostics
    -- Note: ]d, [d, ]D, [D, and <C-w>d are built-in defaults in 0.11+
    -- Explicitly setting them here for consistency and to ensure they work
    vim.keymap.set(
      "n",
      "[d",
      vim.diagnostic.goto_prev,
      vim.tbl_extend("force", opts, { desc = "Previous diagnostic" })
    )
    vim.keymap.set(
      "n",
      "]d",
      vim.diagnostic.goto_next,
      vim.tbl_extend("force", opts, { desc = "Next diagnostic" })
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

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
})

-- Diagnostic signs (using modern vim.diagnostic.config API)
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.HINT] = "⚑",
      [vim.diagnostic.severity.INFO] = "»",
    },
  },
})

-- Enable LSP servers
-- Now handled by mason-lspconfig (see lua/plugins/mason-lspconfig.lua)
-- vim.lsp.enable({
--   "lua_ls",
--   "ts_ls",
--   "pyright",
--   "gopls",
--   "jdtls",
--   "tofu_ls",
--   "yamlls",
--   "ruby_lsp",
--   "bashls",
--   "jsonls",
--   "pbls",
-- })
