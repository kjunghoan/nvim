return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  config = function()
    require("oil").setup{
      float = {
        max_height = 20,
        max_width = 60,
      }
    }
    vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", {desc = "Oil"})
  end
}
