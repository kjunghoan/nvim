-- https://github.com/nvim-treesitter/nvim-treesitter
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    -- Install parsers
    local languages = {
      -- Core
      "lua",
      "vim",
      "vimdoc",
      "query",

      -- languages
      "javascript",
      "typescript",
      "tsx",
      "python",
      "go",
      "gomod",
      "gowork",
      "gotmpl",
      "java",
      "http",

      -- DevOps/Config
      "yaml",
      "json",
      "toml",
      "hcl",
      "dockerfile",
      "proto",

      -- Markup/Web
      "markdown",
      "markdown_inline",
      "html",
      "css",

      -- Utilities
      "bash",
      "make",
      "gitignore",
      "ini",
    }

    -- Install missing parsers
    for _, lang in ipairs(languages) do
      local ok = pcall(vim.treesitter.language.inspect, lang)
      if not ok then
        vim.cmd("TSInstall " .. lang)
      end
    end

    -- Enable treesitter highlighting for all filetypes
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
