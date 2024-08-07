return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup {
      options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        ignore_focus = { "NvimTree" }, -- Ignore the focus of these windows
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { "diagnostics"},
        lualine_x = { "diff" },
        lualine_y = { "searchcount" },
        lualine_z = { "filename"  },
      },
      extensions = { "fugitive", "man", "quickfix" },
    }
  end
}
