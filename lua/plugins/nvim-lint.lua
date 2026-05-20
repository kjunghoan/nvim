-- https://github.com/mfussenegger/nvim-lint
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("lint").linters_by_ft = {}
  end,
}
