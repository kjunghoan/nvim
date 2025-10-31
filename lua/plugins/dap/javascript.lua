-- JavaScript/TypeScript DAP configuration using js-debug-adapter
return {
  "mfussenegger/nvim-dap",
  ft = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  optional = true,
  config = function()
    local dap = require("dap")

    -- Setup js-debug-adapter from Mason
    local mason_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter"
    local js_debug_path = mason_path .. "/js-debug/src/dapDebugServer.js"

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = { js_debug_path, "${port}" },
      },
    }

    -- Node.js configurations
    for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
      dap.configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug Jest Tests",
          -- trace = true, -- include debugger info
          runtimeExecutable = "node",
          runtimeArgs = {
            "./node_modules/jest/bin/jest.js",
            "--runInBand",
          },
          rootPath = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
        },
      }
    end

    -- JS/TS-specific debug keybindings (buffer-local)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
      callback = function(args)
        vim.keymap.set("n", "<leader>df", function()
          require("dap").continue()
        end, { buffer = args.buf, desc = "Debug File" })
      end,
    })
  end,
}
