return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      "Pocco81/DAPInstall.nvim",
    },
    config = function()
      local wk = require("which-key")
      wk.register({
        name = "debug",
        t = { "<cmd>lua require('dap').toggle_breakpoint()<cr>", "toggle breakpoint" },
        c = { "<cmd>lua require('dap').continue()<cr>", "Continue" },
      }, { prefix = "<leader>d" })

      local dap, dapui = require("dap"), require("dapui")
      --use this page for reference documentaion on how to install and configure debuggers
      -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
      require("dapui").setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  -- Add A debugger here
  {
  },
}
