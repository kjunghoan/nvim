return {
  "mfussenegger/nvim-jdtls",
  config = function()
    require("jdtls")
    local wk = require("which-key")
    wk.register({
      r = {
        name = "jdtls",
        o = { "<cmd>lua require'jdtls'.organize_imports()<cr>", "Organize Imports" },
        v = {
          name = "Extract Variable",
          ["1"] = { "<cmd>lua require('jdtls').extract_variable()<cr>", "Extract Variable" },
          ["2"] = { "<Esc><cmd>lua require('jdtls').extract_variable(true)<cr>", "Extract Variable" },
        },
        c = {
          name = "Extract Constant",
          ["1"] = { "<cmd>lua require('jdtls').extract_constant()<cr>", "Extract Constant" },
          ["2"] = { "<cmd>lua require('jdtls').extract_constant(true)<cr>", "Extract Constant" },
        },
        m = { "<cmd>lua require('jdtls').extract_method(true)<cr>", "Extract Method" },
      },
    },{prefix = "<leader>c"})
  end,
}
