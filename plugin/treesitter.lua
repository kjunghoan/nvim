-- https://github.com/nvim-treesitter/nvim-treesitter
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(event)
    local changed_plugin = event.data
    if changed_plugin.spec.name ~= "nvim-treesitter" or changed_plugin.kind ~= "update" then
      return
    end
    if not changed_plugin.active then
      vim.cmd.packadd("nvim-treesitter")
    end
    vim.cmd("TSUpdate")
  end,
})

vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

local parsers_to_install = {
  "bash",
  "c",
  "cmake",
  "cpp",
  "css",
  "csv",
  -- "cuda",
  "devicetree",
  "diff",
  "dockerfile",
  "dtd",
  "editorconfig",
  "git_config",
  "gitcommit",
  "gitignore",
  "go",
  "gomod",
  "gotmpl",
  "gowork",
  "graphql",
  "hcl",
  "html",
  "http",
  "ini",
  "java",
  "javascript",
  "json",
  "json5",
  "just",
  "latex",
  "lua",
  "make",
  "markdown",
  "markdown_inline",
  "nginx",
  "nix",
  "pem",
  "prisma",
  "promql",
  "proto",
  "python",
  "query",
  "regex",
  "ruby",
  "rust",
  "scheme",
  "scss",
  "sql",
  "ssh_config",
  "terraform",
  "toml",
  "tsv",
  "tsx",
  "typescript",
  "typst",
  "vim",
  "vimdoc",
  "vue",
  "xml",
  "yaml",
}

if vim.fn.executable("tree-sitter") == 1 then
  require("nvim-treesitter").install(parsers_to_install)
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user-treesitter", { clear = true }),
  callback = function(event)
    local language = vim.treesitter.language.get_lang(event.match)
    if language and vim.treesitter.language.add(language) then
      vim.treesitter.start(event.buf, language)
    end
  end,
})
