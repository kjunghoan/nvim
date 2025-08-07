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

    -- Go-specific debugging keybindings (keep minimal, general debug actions via standard DAP)
    local wk = require("which-key")
    wk.add({
      { "<leader>Gd",  group = "Debug Go" },
      { "<leader>Gdt", function() require("dap-go").debug_test() end,      desc = "Debug Test" },
      { "<leader>GdT", function() require("dap-go").debug_last_test() end, desc = "Debug Last Test" },
    }, { buffer = true, filetype = "go" })
  end,
}
