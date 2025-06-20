-- lua/plugins/ltex_extra.lua
return {
  "barreiroleo/ltex_extra.nvim",
  ft = { "markdown", "tex", "latex", "text" },
  dependencies = { "neovim/nvim-lspconfig" },
  config = function()
    require("ltex_extra").setup {
      load_langs = { "en-US" },
      init_check = true,
      path = vim.fn.expand("~/.config/nvim/spell"),
      log_level = "none",
      server_opts = {
        on_attach = function(_, bufnr)
          -- Create commands for the current buffer
          vim.api.nvim_buf_create_user_command(bufnr, "LtexReload", function()
            require("ltex_extra").reload()
          end, { desc = "Reload LTeX dictionaries" })

          -- Setup which-key mappings for LTeX
          local wk = require("which-key")
          wk.add({
            { "<leader>lx",  group = "LTeX Extra" },
            { "<leader>lxr", ":LtexReload<CR>",   desc = "Reload Dictionaries" },
          }, { buffer = bufnr })
        end
      }
    }
  end
}
