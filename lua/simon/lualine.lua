local M = {
  "nvim-lualine/lualine.nvim",
}

function M.config()
  require("lualine").setup {
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      --ignore_focus = { "NvimTree" }, -- add back if adding nvimtree
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = { "diagnostics" },
      lualine_x = { "diff" },
      lualine_y = {"searchcount"},
      lualine_z = {"filename"},
    },
    extensions = { "quickfix", "man", "fugitive" },
  }
end

return M

