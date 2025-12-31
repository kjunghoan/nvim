return {
  "nvim-mini/mini.icons",
  version = "*",
  config = function()
    local micon = require("mini.icons")
    micon.setup()
    micon.mock_nvim_web_devicons()
  end,
}
