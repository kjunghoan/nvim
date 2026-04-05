-- lua/plugins/dap/init.lua
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Setup DAP-UI
    dapui.setup({
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          position = "left",
          size = 40,
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 },
          },
          position = "bottom",
          size = 10,
        },
      },
    })

    -- Setup virtual text
    require("nvim-dap-virtual-text").setup()

    -- Auto open/close DAP UI
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- DAP signs
    vim.fn.sign_define("DapBreakpoint", {
      text = "🔴",
      texthl = "DapBreakpoint",
      linehl = "",
      numhl = "",
    })
    vim.fn.sign_define("DapBreakpointCondition", {
      text = "🔶",
      texthl = "DapBreakpointCondition",
      linehl = "",
      numhl = "",
    })
    vim.fn.sign_define("DapLogPoint", {
      text = "💬",
      texthl = "DapLogPoint",
      linehl = "",
      numhl = "",
    })
    vim.fn.sign_define("DapStopped", {
      text = "👉",
      texthl = "DapStopped",
      linehl = "DapStoppedLine",
      numhl = "",
    })
    vim.fn.sign_define("DapBreakpointRejected", {
      text = "❌",
      texthl = "DapBreakpointRejected",
      linehl = "",
      numhl = "",
    })

    -- General debug keybindings
    vim.keymap.set("n", "<leader>db", function()
      require("dap").toggle_breakpoint()
    end, { desc = "Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dc", function()
      require("dap").continue()
    end, { desc = "Continue" })
    vim.keymap.set("n", "<leader>di", function()
      require("dap").step_into()
    end, { desc = "Step Into" })
    vim.keymap.set("n", "<leader>do", function()
      require("dap").step_over()
    end, { desc = "Step Over" })
    vim.keymap.set("n", "<leader>dO", function()
      require("dap").step_out()
    end, { desc = "Step Out" })
    vim.keymap.set("n", "<leader>dr", function()
      require("dap").repl.open()
    end, { desc = "Open REPL" })
    vim.keymap.set("n", "<leader>dl", function()
      require("dap").run_last()
    end, { desc = "Run Last" })
    vim.keymap.set("n", "<leader>dt", function()
      require("dap").terminate()
    end, { desc = "Terminate" })
  end,
}
