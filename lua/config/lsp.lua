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

    -- Go to implementation
    vim.keymap.set(
      "n",
      "gi",
      vim.lsp.buf.implementation,
      vim.tbl_extend("force", opts, { desc = "Go to implementation" })
    )

    -- Go to type definition
    vim.keymap.set(
      "n",
      "gT",
      vim.lsp.buf.type_definition,
      vim.tbl_extend("force", opts, { desc = "Go to type definition" })
    )

    -- Type definition in floating window (peek)
    vim.keymap.set("n", "gt", function()
      local client = vim.lsp.get_clients({ bufnr = bufnr })[1]
      if not client then
        vim.notify("No LSP client attached", vim.log.levels.INFO)
        return
      end
      local params = vim.lsp.util.make_position_params(0)
      vim.lsp.buf_request(0, "textDocument/typeDefinition", params, function(err, result)
        if err or not result or vim.tbl_isempty(result) then
          vim.notify("No type definition found", vim.log.levels.INFO)
          return
        end
        local location = vim.islist(result) and result[1] or result
        local uri = location.uri or location.targetUri
        local range = location.range or location.targetSelectionRange
        local target_bufnr = vim.uri_to_bufnr(uri)
        vim.fn.bufload(target_bufnr)
        local start_line = range.start.line
        local lines =
          vim.api.nvim_buf_get_lines(target_bufnr, start_line, start_line + 15, false)
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
        local ft = vim.bo[target_bufnr].filetype
        vim.bo[buf].filetype = ft
        vim.lsp.util.open_floating_preview(lines, ft, { border = "rounded" })
      end)
    end, vim.tbl_extend("force", opts, { desc = "Type definition (float)" }))

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
