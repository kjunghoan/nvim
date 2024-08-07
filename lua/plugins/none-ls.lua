return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup(
      {
        null_ls.builtins.formatting.stylua,   -- Lua formatter
        null_ls.builtins.formatting.prettier, -- JavaScript formatter
        null_ls.builtins.completion.spell,    -- Spell checker
        null_ls.builtins.formatting.black,    -- Python formatter
      }
    )
    local wk = require("which-key")
    wk.register {
      ["<leader>bf"] = { vim.lsp.buf.format, "Format Buffer", { mode = "n" } },
    }
  end
}

