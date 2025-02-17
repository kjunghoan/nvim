return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
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

    -- Add formatters as they're available
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

    null_ls.setup({
      sources = sources,
      diagnostics_format = "[#{s}] #{m}",
    })
  end,
}
