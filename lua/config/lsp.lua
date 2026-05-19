-- LSP foundation.
-- Server configs live in `lsp/<name>.lua` (auto-loaded by 0.11+ runtime).
-- `after/lsp/<name>.lua` overrides extend the base configs.

-- Global defaults applied to every server
vim.lsp.config("*", {
  root_markers = { ".git" },
})

-- Auto-enable every server that has a `lsp/<name>.lua` config.
-- Drop a file in `lsp/`, server enables itself on next launch.
for _, file in ipairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
  local name = file:match("lsp/(.+)%.lua$")
  if name then
    vim.lsp.enable(name)
  end
end

-- Per-buffer setup on attach: keymaps only.
-- (Server-specific keymaps go in the server's plugin module, e.g. jdtls.)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, {
        buffer = bufnr,
        noremap = true,
        silent = true,
        desc = desc,
      })
    end

    -- Navigation
    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "gT", vim.lsp.buf.type_definition, "Go to type definition")
    -- <C-S> is the default for signature_help but conflicts with tmux prefix.
    map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

    -- Diagnostics
    map("n", "<leader>ld", vim.diagnostic.open_float, "Show diagnostic")
    map("n", "<leader>q", vim.diagnostic.setloclist, "Diagnostic list")
  end,
})

-- Diagnostic display: virtual_lines on current line only (0.12 feature).
-- Avoids the cramped truncation of virtual_text.
vim.diagnostic.config({
  virtual_lines = { current_line = true },
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

-- LSP-driven folding (0.12 feature).
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.lsp.foldexpr()"
