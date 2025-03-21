return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    local nb = null_ls.builtins
    local eslint = require("none-ls.diagnostics.eslint_d")
    local ruff = require("none-ls.diagnostics.ruff")

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

    local function has_file(files, default_value)
      default_value = default_value or false
      return function(utils)
        local has_files = utils.root_has_file(files)
        if has_files then
          return true
        else
          return default_value
        end
      end
    end

    -- Initialize sources table
    local sources = {}

    -- Python Configuration - now with options to work outside projects
    if is_available("ruff") then
      table.insert(sources, ruff) -- Use the imported ruff directly
    end
    if is_available("black") then
      table.insert(
        sources,
        nb.formatting.black.with({
          -- Always true to work in any directory with Python files
          condition = has_file({
            "pyproject.toml",
            "setup.cfg",
          }, true), -- Set default to true
        })
      )
    end
    if is_available("isort") then
      table.insert(
        sources,
        nb.formatting.isort.with({
          -- Always true to work in any directory with Python files
          condition = has_file({
            "pyproject.toml",
            ".isort.cfg",
            "setup.cfg",
          }, true), -- Set default to true
        })
      )
    end

    -- Keep your existing formatters
    if is_available("prettier") then
      table.insert(sources, nb.formatting.prettier)
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
      diagnostics_format = "[#{s}] #{m}",
    })

    -- Add which-key mappings for formatting
    local wk = require("which-key")
    wk.add({
      { "<leader>l", group = "LSP" },
      {
        "<leader>lf",
        function()
          vim.lsp.buf.format()
        end,
        desc = "Format Buffer",
      },
      {
        "<leader>li",
        function()
          local sources = null_ls.get_sources({ name = "isort" })
          if sources and #sources > 0 then
            vim.lsp.buf.format({ sources = sources })
          end
        end,
        desc = "Format Imports",
      },
    })
  end,
}
