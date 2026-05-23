-- https://github.com/folke/snacks.nvim/blob/main/docs/terminal.md
return {
  opts = {
    terminal = {
      enabled = true,
    },
  },
  keys = {
    {
      "<c-/>",
      function() Snacks.terminal.toggle() end,
      mode = { "n", "t" },
      desc = "Toggle Terminal",
    },
    {
      "<c-_>",
      function() Snacks.terminal.toggle() end,
      mode = { "n", "t" },
      desc = "Toggle Terminal",
    },
  },
}
