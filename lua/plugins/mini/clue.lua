return {
  "nvim-mini/mini.clue",
  version = "*",
  config = function()
    local miniclue = require("mini.clue")
    miniclue.setup({
      triggers = {
        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },

        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },

        -- Built-in completion
        { mode = "i", keys = "<C-x>" },

        -- `g` key
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },

        -- Marks
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },

        -- Registers
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },

        -- Window commands
        { mode = "n", keys = "<C-w>" },

        -- `z` key
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
      },

      clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),

        -- Leader group headings
        { mode = "n", keys = "<Leader>d", desc = "+Debug" },
        { mode = "n", keys = "<Leader>g", desc = "+Git" },
        { mode = "n", keys = "<Leader>l", desc = "+LSP" },
        { mode = "n", keys = "<Leader>L", desc = "+LaTeX" },
        { mode = "n", keys = "<Leader>o", desc = "+Obsidian" },
        { mode = "n", keys = "<Leader>p", desc = "+Oil" },
        { mode = "n", keys = "<Leader>r", desc = "+Refactor" },
        { mode = "n", keys = "<Leader>s", desc = "+Split" },
        { mode = "n", keys = "<Leader>t", desc = "+Test" },
        { mode = "n", keys = "<Leader>f", desc = "+Picker" },
        { mode = "n", keys = "<Leader>c", desc = "+Copilot" },
      },
      window = {
        delay = 300,
        config = {
          width = "auto",
        },
      },
    })
  end,
}
