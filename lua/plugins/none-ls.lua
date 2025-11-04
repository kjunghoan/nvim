return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "jay-babu/mason-null-ls.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      diagnostics_format = "[#{s}] #{m}",
    })

    -- Auto-setup all installed Mason tools with none-ls
    require("mason-null-ls").setup({
      ensure_installed = nil, -- Use mason-tool-installer instead
      automatic_installation = false,
      automatic_setup = true, -- Automatically setup all installed sources
    })
  end,
}
