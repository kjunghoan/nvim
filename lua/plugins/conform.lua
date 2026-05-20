-- https://github.com/stevearc/conform.nvim
return {
  "stevearc/conform.nvim",
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>lf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      desc = "Format",
    },
  },
  config = function()
    require("conform").setup({})
  end,
}
