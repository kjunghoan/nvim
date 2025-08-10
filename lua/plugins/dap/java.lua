-- lua/plugins/dap/java.lua
return {
  "mfussenegger/nvim-jdtls", -- nvim-jdtls comes with the debug adapter
  ft = "java",
  config = function()
    -- The main jdtls setup is in plugins/jdtls.lua
    -- This file just adds the debug-specific keymaps

    local wk = require("which-key")
    wk.add({
      { "<leader>d", group = "Debug" },
      { "<leader>df", function() require("lsp.old.jdtls").test_nearest_method() end, desc = "Debug Method" },
      { "<leader>dt", function() require("lsp.old.jdtls").test_class() end, desc = "Debug Class" },
    }, { buffer = true, filetype = "java" })
  end,
}
