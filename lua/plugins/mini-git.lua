-- https://github.com/nvim-mini/mini-git
return {
  "nvim-mini/mini-git",
  version = false,
  config = function()
    require("mini.git").setup({
      job = {
        git_executable = "git",
        timeout = 30000,
      },
      command = {
        split = "vertical",
      },
    })
  end,
}
