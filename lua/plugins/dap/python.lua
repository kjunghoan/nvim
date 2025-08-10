-- lua/plugins/dap/python.lua
return {
  "mfussenegger/nvim-dap-python",
  ft = "python",
  config = function()
    -- NOTE: This assumes you have a virtual environment set up for Neovim's Python host.
    -- You may need to change this path to your actual Python interpreter.
    local python_path = vim.fn.expand("~/.config/nvim/venv/neovim/bin/python")
    require("dap-python").setup(python_path)

    local wk = require("which-key")
    wk.add({
      { "<leader>d", group = "Debug" },
      { "<leader>df", function() require("dap-python").test_method() end, desc = "Debug Method" },
      { "<leader>dt", function() require("dap-python").test_class() end, desc = "Debug Class" },
    }, { buffer = true, filetype = "python" })
  end,
}
