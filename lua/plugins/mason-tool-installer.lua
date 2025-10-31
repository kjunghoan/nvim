-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "mason-org/mason.nvim" },
  config = function()
    require("mason-tool-installer").setup({
      ensure_installed = {
        -- LSP servers
        "lua-language-server",
        "typescript-language-server",
        "pyright",
        "gopls",
        "jdtls",
        "tofu-ls",
        "yaml-language-server",
        "ruby-lsp",
        "bash-language-server",

        -- Formatters
        "stylua",
        "prettier",
        "black",
        "gofumpt",
        "google-java-format",
        "shfmt",

        -- Debuggers
        "debugpy",
        "java-debug-adapter",
        "delve",
        "js-debug-adapter",
      },
      auto_update = false,
      run_on_start = true,
      start_delay = 3000, -- 3 second delay to not slow down startup
    })
  end,
}
