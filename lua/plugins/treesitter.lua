-- https://github.com/nvim-treesitter/nvim-treesitter
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    ts.setup({})

    ts.install({
      "lua",
      "vim",
      "vimdoc",
      "query",
      "markdown",
      "markdown_inline",
      "bash",
    })

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("user-treesitter", { clear = true }),
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        if not ft or ft == "" then
          return
        end
        local lang = vim.treesitter.language.get_lang(ft) or ft

        if #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".so", false) > 0 then
          pcall(vim.treesitter.start, args.buf, lang)
          return
        end

        vim.notify("treesitter: installing parser for " .. lang, vim.log.levels.INFO)
        pcall(require("nvim-treesitter").install, { lang })
      end,
    })
  end,
}
