-- https://github.com/stevearc/conform.nvim
vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    nix = { "nixfmt" },
    sh = { "shfmt" },
    python = { "ruff_format" },
    rust = { "rustfmt" },
    json = { "prettier" },
    yaml = { "prettier" },
    css = { "prettier" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    vue = { "prettier" },
    markdown = { "prettier" },
    typst = { "typstyle" },
    tex = { "tex-fmt" },
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
})
vim.keymap.set("n", "<leader>lf", function()
  require("conform").format({ async = true })
end, { desc = "Format" })
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
