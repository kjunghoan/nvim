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
        if vim.bo[args.buf].buftype ~= "" then
          return
        end
        local ft = vim.bo[args.buf].filetype
        if not ft or ft == "" then
          return
        end
        local lang = vim.treesitter.language.get_lang(ft) or ft

        if #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".so", false) > 0 then
          pcall(vim.treesitter.start, args.buf, lang)
          return
        end

        -- skip filetypes nvim-treesitter has no parser for (oil, lazy, etc.)
        local parsers_ok, parsers = pcall(require, "nvim-treesitter.parsers")
        if not parsers_ok or parsers[lang] == nil then
          return
        end

        vim.notify("treesitter: installing parser for " .. lang, vim.log.levels.INFO)
        vim.schedule(function()
          pcall(function()
            require("nvim-treesitter").install({ lang }):wait(60000)
          end)
          if vim.api.nvim_buf_is_valid(args.buf) then
            pcall(vim.treesitter.start, args.buf, lang)
          end
        end)
      end,
    })
  end,
}
