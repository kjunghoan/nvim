return {
  {
    "nvim-mini/mini.ai",
    version = "*",
    config = function()
      require("mini.ai").setup()
    end,
  },
  {
    "nvim-mini/mini.align",
    version = "*",
    config = function()
      require("mini.align").setup()
    end,
  },
  {
    "nvim-mini/mini.pairs",
    version = "*",
    config = function()
      require("mini.pairs").setup()
    end,
  },
  {
    "nvim-mini/mini.surround",
    version = "*",
    config = function()
      require("mini.surround").setup()
    end,
  },
  {
    "nvim-mini/mini.extra",
    version = "*",
    config = function()
      require("mini.extra").setup()
    end,
  },
  {
    "nvim-mini/mini.misc",
    version = "*",
    config = function()
      require("mini.misc").setup()
    end,
  },
  {
    "nvim-mini/mini.indentscope",
    version = "*",
    config = function()
      require("mini.indentscope").setup()
    end,
  },
  {
    "nvim-mini/mini.trailspace",
    version = "*",
    config = function()
      require("mini.trailspace").setup()
    end,
  },
}
