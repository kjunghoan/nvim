-- Global LSP configuration for Neovim 0.11+
-- Uses built-in vim.lsp instead of nvim-lspconfig

-- Global settings for all LSP servers
vim.lsp.config("*", {
  root_markers = { ".git" },
})

-- LspAttach autocmd for keybindings and per-buffer setup
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf

    -- Neovim 0.11+ provides these by default:
    -- gra  - code actions
    -- grn  - rename
    -- grr  - references
    -- gri  - implementation
    -- grt  - type definition
    -- gO   - document symbols
    -- K    - hover

    -- Set formatexpr to use LSP formatting with gq
    vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"

    -- Additional keybindings
    local opts = { buffer = bufnr, noremap = true, silent = true }

    -- Go to definition
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))

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

    -- Workspace folders
    vim.keymap.set(
      "n",
      "<leader>wa",
      vim.lsp.buf.add_workspace_folder,
      vim.tbl_extend("force", opts, { desc = "Add workspace folder" })
    )
    vim.keymap.set(
      "n",
      "<leader>wr",
      vim.lsp.buf.remove_workspace_folder,
      vim.tbl_extend("force", opts, { desc = "Remove workspace folder" })
    )
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, vim.tbl_extend("force", opts, { desc = "List workspace folders" }))

    -- Diagnostics
    -- Note: ]d, [d, ]D, [D, and <C-w>d are built-in defaults in 0.11+
    -- Only adding supplementary keybindings here
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

-- Diagnostic signs
local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "»" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Enable LSP servers
-- Server configs are in lsp/*.lua files
vim.lsp.enable({ "lua_ls", "ts_ls", "pyright", "gopls", "jdtls", "tofu_ls", "yamlls", "ruby_lsp", "bashls" })
