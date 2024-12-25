return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local nb = null_ls.builtins

    -- Helper function to check if a command is available
    local function is_available(command)
      local handle = io.popen("command -v " .. command .. " >/dev/null 2>&1 && echo 'true' || echo 'false'")
      if handle then
        local result = handle:read("*a")
        handle:close()
        return result:match("true") ~= nil
      end
      return false
    end

    -- Initialize sources table
    local sources = {}

    -- Add formatters that are installed
    if is_available("prettier") then
      table.insert(sources, nb.formatting.prettier)
    end
    if is_available("black") then
      table.insert(sources, nb.formatting.black)
    end
    if is_available("isort") then
      table.insert(sources, nb.formatting.isort)
    end
    if is_available("stylua") then
      table.insert(sources, nb.formatting.stylua)
    end
    if is_available("shfmt") then
      table.insert(sources, nb.formatting.shfmt)
    end
    if is_available("yamlfmt") then
      table.insert(sources, nb.formatting.yamlfmt)
    end

    -- Add built-in spell checker
    table.insert(sources, nb.completion.spell)

    null_ls.setup({
      sources = sources,
      -- debug = true,  -- Uncomment for debugging
    })

    -- Add which-key mappings for formatting
    local wk = require("which-key")
    wk.register({ -- TODO wk spec
      l = {
        name = "LSP",
        f = {
          function()
            vim.lsp.buf.format()
          end,
          "Format Buffer",
        },
        i = {
          function()
            local null_ls = require("null-ls")
            local sources = null_ls.get_sources({ name = "isort" })
            if sources and #sources > 0 then
              vim.lsp.buf.format({ sources = sources })
            end
          end,
          "Format Imports",
        },
      },
    }, { prefix = "<leader>" })
  end,
}
