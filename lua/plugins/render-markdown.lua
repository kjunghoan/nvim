return {
  'MeanderingProgrammer/render-markdown.nvim',
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- If you use the mini.nvim suite
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' }, -- If you use standalone mini plugins
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- If you prefer nvim-web-devicons
  opts = {},
  config = function(_, opts)
    require('render-markdown').setup(opts)
  end,
}
