-- lua/plugins/dap/python.lua
return {
  "mfussenegger/nvim-dap-python",
  ft = "python",
  config = function()
    -- Use uv to handle virtual environments automatically
    -- This works with uv projects and auto-detects .venv
    require("dap-python").setup("uv")

    -- Python-specific debug keybindings (buffer-local, only in Python files)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "python",
      callback = function(args)
        vim.keymap.set("n", "<leader>df", function()
          require("dap-python").test_method()
        end, { buffer = args.buf, desc = "Debug Method" })
        vim.keymap.set("n", "<leader>dT", function()
          require("dap-python").test_class()
        end, { buffer = args.buf, desc = "Debug Class" })
      end,
    })
  end,
}
