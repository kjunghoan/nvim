-- https://github.com/stevearc/conform.nvim
return {
  "stevearc/conform.nvim",
  cmd = "ConformInfo",
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("conform_formatexpr", { clear = true }),
      callback = function(args)
        vim.bo[args.buf].formatexpr = "v:lua.require'conform'.formatexpr()"
      end,
    })
  end,
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      nix = { "nixfmt" },
      sh = { "shfmt" },
      python = { "ruff_format" },
      json = { "prettier" },
      yaml = { "prettier" },
      css = { "prettier" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      vue = { "prettier" },
      markdown = { "prettier" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
  },
  keys = {
    {
      "<leader>lf",
      function()
        require("conform").format({ async = true })
      end,
      desc = "Format",
    },
  },
}
