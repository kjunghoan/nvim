-- lua/plugins/dap/go.lua
return {
  "leoluz/nvim-dap-go",
  ft = "go",
  optional = true,
  config = function()
    require("dap-go").setup()

    -- Go-specific debug keybindings (buffer-local, only in Go files)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "go",
      callback = function(args)
        vim.keymap.set("n", "<leader>df", function()
          require("dap-go").debug_test()
        end, { buffer = args.buf, desc = "Debug Test" })

        vim.keymap.set("n", "<leader>dL", function()
          require("dap-go").debug_last_test()
        end, { buffer = args.buf, desc = "Debug Last Test" })
      end,
    })
  end,
}
