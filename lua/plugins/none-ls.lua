return { -- Currently debugging diagnostics
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    -- print ("loading null-ls conf")
    local null_ls = require("null-ls")
    local nb = null_ls.builtins
    null_ls.setup({
      sources = {
        -- Formatting
        nb.formatting.prettier, -- JavaScript formatter
        nb.formatting.black, -- Python formatter
        nb.formatting.isort, -- Python import formatter
        nb.formatting.stylua, -- Lua formatter
        nb.formatting.yamlfmt, -- YAML formatter
        nb.formatting.shfmt, -- Shellscript formatter
        -- nb.formatting.ruff,     -- Python formatter (civic tech DC)

        -- Diagnostics
        -- doesn't work without require for some reason
        require("none-ls.diagnostics.eslint_d"), -- JavaScript linter

        -- Code Actions
        nb.code_actions.eslint_d, -- JavaScript code actions
        
        -- Completion
        nb.completion.spell, -- Spell checker
        -- debug = true
      },
    })
  end,
}
