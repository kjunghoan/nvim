return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    local null_ls = require("null-ls")
    local nb = null_ls.builtins
    null_ls.setup(
      {
        -- Formatting
        nb.formatting.stylua,   -- Lua formatter

        nb.formatting.black,    -- Python formatter
        nb.formatting.isort,    -- Python import formatter

        -- Diagnostics
        -- nb.diagnostics.stylua, -- Lua diagnostics
        -- nb.diagnostics.eslint_d, -- EsLint diagnostics
        -- nb.formatting.sonarlint, -- JavaScript formatter

        -- Completion
        nb.completion.spell,    -- Spell checker

      }
    )
    local wk = require("which-key")
    wk.register {
      ["<leader>bf"] = { vim.lsp.buf.format, "Format Buffer", { mode = "n" } },
    }
  end
}
