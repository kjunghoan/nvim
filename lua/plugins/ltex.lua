return {
  {
    "barreiroleo/ltex_extra.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    ft = { "markdown", "tex", "text", "mail" }, -- Add file types you want LTeX to check
    config = function()
      -- Configure ltex language server
      require("lspconfig").ltex.setup({
        on_attach = function(client, bufnr)
          -- Configure ltex_extra dictionary management
          local ltex_extra = require("ltex_extra")
          ltex_extra.setup({
            load_langs = { "en-US", "en-GB", "ko" }, -- Preload dictionaries for these languages
            init_check = true, -- Check on startup
            path = vim.fn.stdpath("config") .. "/spell", -- Store dictionaries in the spell directory
            log_level = "none",
          })
          
          -- Get which-key for keybinding registration
          local wk = require("which-key")
          
          -- Function to change LTeX language
          local function change_ltex_language()
            vim.ui.select(
              { "en-US", "en-GB", "ko" }, 
              { prompt = "Select language:" }, 
              function(choice)
                if choice then
                  -- Update the language setting for the current buffer
                  client.config.settings.ltex.language = choice
                  -- Apply the new settings to the client
                  client.notify('workspace/didChangeConfiguration', {
                    settings = client.config.settings
                  })
                  vim.notify("LTeX language changed to " .. choice, vim.log.levels.INFO)
                end
              end
            )
          end
          
          -- Register additional keybindings using LSP code actions
          wk.register({
            ["<leader>ly"] = { 
              name = "LTeX", 
              a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "LTeX Code Actions" },
              r = { function() 
                -- Reload the ltex_extra dictionaries
                ltex_extra.setup({
                  load_langs = { "en-US", "en-GB", "ko" },
                  init_check = true,
                  path = vim.fn.stdpath("config") .. "/spell",
                })
                vim.notify("LTeX dictionaries reloaded", vim.log.levels.INFO)
              end, "Reload LTeX Dictionaries" },
              l = { change_ltex_language, "Switch language" },
            },
          }, { buffer = bufnr })
        end,
        
        settings = {
          ltex = {
            -- Configure multiple language variants
            language = "en-US", -- Default language
            additionalRules = {
              enablePickyRules = true, -- Enable picky rules for stricter checking
            },
            -- Dictionaries for the configured languages
            dictionary = {
              ["en-US"] = {}, -- Will be populated by ltex_extra
              ["en-GB"] = {}, -- Will be populated by ltex_extra
              ["ko"] = {},    -- Will be populated by ltex_extra
            },
            -- Words to disable checking for
            disabledRules = {},
            hiddenFalsePositives = {},
            -- Configure LTeX more precisely
            checkFrequency = "edit", -- Check on edit (alternatives: "save", "manual")
            diagnosticSeverity = "information", -- Set diagnostic severity
          },
        },
      })
    end,
  }
}
