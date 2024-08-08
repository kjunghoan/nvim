return {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,
  config = function()
    local configs = require("nvim-treesitter.configs")

    vim.filetype.add({
      extension = { rasi = "rasi", rofi = "rasi", wofi = "rasi" },
      filename = {
        ["vifmrc"] = "vim",
      },
      pattern = {
        [".*/waybar/config"] = "jsonc",
        [".*/mako/config"] = "dosini",
        [".*/kitty/.+%.conf"] = "bash",
        [".*/hypr/.+%.conf"] = "hyprlang",
        ["%.env%.[%w_.-]+"] = "sh",
      },
    })

    configs.setup({
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "query",
        "javascript",
        "json",
        "typescript",
        "tsx",
        "html",
        "css",
        "scss",
        "yaml",
        "toml",
        "python",
        "java",
        "go",
        "bash",
        "dockerfile",
        "graphql",
        "dart",
        "swift",
        "prisma",
        "markdown",
        "markdown_inline",
        "graphql",
        "gitignore",
        "query",
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
