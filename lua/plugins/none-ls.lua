return { -- Currently debugging diagnostics
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    -- print ("loading null-ls conf")
    local null_ls = require("null-ls")
    local nb = null_ls.builtins
    null_ls.setup(
      {
        -- Formatting
        -- nb.formatting.stylua,   -- Lua formatter

        -- nb.formatting.black,    -- Python formatter
        nb.formatting.ruff,     -- Python formatter (civic tech DC)
        nb.formatting.isort,    -- Python import formatter
        
        -- nb.formatting.sonarlint, -- JavaScript formatter
        nb.formatting.prettier,  -- JavaScript formatter

        -- Diagnostics
        -- nb.diagnostics.stylua, -- Lua diagnostics
        -- nb.diagnostics.eslint_d, -- EsLint diagnostics

        -- Completion
        nb.completion.spell,    -- Spell checker
        -- debug = true

      }
    )
    local wk = require("which-key")
    wk.register {
      ["<leader>bf"] = { vim.lsp.buf.format, "Format Buffer", { mode = "n" } },
    }
  end
}
