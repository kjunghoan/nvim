-- lua/plugins/go-debug.lua
return {
  "leoluz/nvim-dap-go",
  dependencies = {
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
  },
  ft = "go",
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Setup DAP-UI
    dapui.setup({
      layouts = {
        {
          elements = {
            { id = "scopes",      size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks",      size = 0.25 },
            { id = "watches",     size = 0.25 },
          },
          position = "left",
          size = 40,
        },
        {
          elements = {
            { id = "repl",    size = 0.5 },
            { id = "console", size = 0.5 },
          },
          position = "bottom",
          size = 10,
        },
      },
    })

    -- Setup virtual text
    require("nvim-dap-virtual-text").setup({
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      only_first_definition = true,
      all_references = false,
      display_callback = function(variable, buf, stackframe, node, options)
        if options.virt_text_pos == 'inline' then
          return ' = ' .. variable.value
        else
          return variable.name .. ' = ' .. variable.value
        end
      end,
    })

    -- Setup nvim-dap-go
    require("dap-go").setup({
      -- Additional dap configurations can be added here
      dap_configurations = {
        {
          type = "go",
          name = "Attach remote",
          mode = "remote",
          request = "attach",
        },
        {
          type = "go",
          name = "Debug test", -- configuration for debugging test files
          request = "launch",
          mode = "test",
          program = "${file}"
        },
        {
          type = "go",
          name = "Debug test (go.mod)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}"
        }
      },
      delve = {
        -- the path to the executable dlv which will be used for debugging.
        path = "dlv",
        initialize_timeout_sec = 20,
        port = "${port}",
        args = {},
        build_flags = "",
        detached = vim.fn.has("win32") == 0,
        cwd = nil,
      },
    })

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
    vim.fn.sign_define('DapBreakpoint', {
      text = '🔴',
      texthl = 'DapBreakpoint',
      linehl = '',
      numhl = ''
    })
    vim.fn.sign_define('DapBreakpointCondition', {
      text = '🔶',
      texthl = 'DapBreakpointCondition',
      linehl = '',
      numhl = ''
    })
    vim.fn.sign_define('DapLogPoint', {
      text = '💬',
      texthl = 'DapLogPoint',
      linehl = '',
      numhl = ''
    })
    vim.fn.sign_define('DapStopped', {
      text = '👉',
      texthl = 'DapStopped',
      linehl = 'DapStoppedLine',
      numhl = ''
    })
    vim.fn.sign_define('DapBreakpointRejected', {
      text = '❌',
      texthl = 'DapBreakpointRejected',
      linehl = '',
      numhl = ''
    })

    -- Which-key mappings for debugging
    local wk = require("which-key")
    wk.add({
      { "<leader>d",  group = "Debug" },
      { "<leader>db", function() dap.toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
      { "<leader>dB", function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Conditional Breakpoint" },
      { "<leader>dc", function() dap.continue() end,                                             desc = "Continue" },
      { "<leader>dC", function() dap.run_to_cursor() end,                                        desc = "Run to Cursor" },
      { "<leader>di", function() dap.step_into() end,                                            desc = "Step Into" },
      { "<leader>do", function() dap.step_over() end,                                            desc = "Step Over" },
      { "<leader>dO", function() dap.step_out() end,                                             desc = "Step Out" },
      { "<leader>dr", function() dap.repl.toggle() end,                                          desc = "Toggle REPL" },
      { "<leader>dl", function() dap.run_last() end,                                             desc = "Run Last" },
      { "<leader>du", function() dapui.toggle() end,                                             desc = "Toggle UI" },
      { "<leader>dt", function() require("dap-go").debug_test() end,                             desc = "Debug Test",            ft = "go" },
      { "<leader>dT", function() require("dap-go").debug_last_test() end,                        desc = "Debug Last Test",       ft = "go" },
      { "<leader>dx", function() dap.terminate() end,                                            desc = "Terminate" },
    })
  end,
}
