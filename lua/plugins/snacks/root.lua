-- https://github.com/folke/snacks.nvim
-- Single canonical snacks spec. opts/keys/init each scan the sibling files in
-- this dir and pull only their matching section. Add a new
-- lua/plugins/snacks/<feature>.lua returning { opts=, keys=, init= } and it
-- wires itself in with no edits here. Spec'd as plugins.snacks.root (the exact
-- module, not the dir) so lazy.nvim does not import the fragments as specs.

local cached

local function fragments()
  if cached then
    return cached
  end
  cached = {}
  local files = vim.api.nvim_get_runtime_file("lua/plugins/snacks/*.lua", true)
  for _, path in ipairs(files) do
    local name = path:match("([^/]+)%.lua$")
    if name and name ~= "root" then
      cached[#cached + 1] = require("plugins.snacks." .. name)
    end
  end
  return cached
end

return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  opts = function()
    local acc = {}
    for _, frag in ipairs(fragments()) do
      acc = vim.tbl_deep_extend("force", acc, frag.opts or {})
    end
    return acc
  end,
  keys = function()
    local keys = {}
    for _, frag in ipairs(fragments()) do
      for _, key in ipairs(frag.keys or {}) do
        keys[#keys + 1] = key
      end
    end
    return keys
  end,
  init = function()
    for _, frag in ipairs(fragments()) do
      if frag.init then
        frag.init()
      end
    end
  end,
}
