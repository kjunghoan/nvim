-- lua/plugins/dap/go.lua
return {
  "leoluz/nvim-dap-go",
  ft = "go",
  dependencies = {
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    require("dap-go").setup({
      dap_configurations = {
        {
          type = "go",
          name = "Debug File",
          request = "launch",
          program = "${file}"
        },
      }
    })
    local wk = require("which-key")
    wk.add({
      { "<leader>d",  group = "Debug" },
      {
        "<leader>df",
        function()
          require('dap').run({
            type = 'go',
            name = 'Debug File',
            request = 'launch',
            program =
            '${file}'
          })
        end,
        desc = "Debug File"
      },
      { "<leader>dt", function() require("dap-go").debug_test() end,      desc = "Debug Test (Nearest)" },
      { "<leader>dT", function() require("dap-go").debug_last_test() end, desc = "Debug Last Test" },
    }, { buffer = true, filetype = "go" })
  end,
}
