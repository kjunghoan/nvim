return {
  {
    "barreiroleo/ltex_extra.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    ft = { "markdown", "tex", "text", "mail" },
    config = function()
      local ltex_extra = require("ltex_extra")

      local ignore_words = {
        ["en-US"] = {},
        ["en-GB"] = {},
        ["ko"] = {},
      }

      local last_check_time = 0
      local check_throttle_ms = 2000 -- Only check every 2 seconds

      local function throttled_check(check_func)
        return function(...)
          local current_time = vim.loop.now()
          if current_time - last_check_time > check_throttle_ms then
            last_check_time = current_time
            return check_func(...)
          end
          return false
        end
      end

      require("lspconfig").ltex.setup({
        on_attach = function(client, bufnr)
          ltex_extra.setup({
            load_langs = { "en-US", "en-GB", "ko" },
            init_check = false, -- Disable initial check
            path = vim.fn.stdpath("config") .. "/spell",
            log_level = "error",
          })

          for lang, words in pairs(ignore_words) do
            for _, word in ipairs(words) do
              if not client.config.settings.ltex.dictionary[lang] then
                client.config.settings.ltex.dictionary[lang] = {}
              end
              table.insert(client.config.settings.ltex.dictionary[lang], word)
            end
          end

          client.notify("workspace/didChangeConfiguration", {
            settings = client.config.settings,
          })

          local wk = require("which-key")

          local function change_ltex_language()
            vim.ui.select({ "en-US", "en-GB", "ko" }, { prompt = "Select language:" }, function(choice)
              if choice then
                client.config.settings.ltex.language = choice
                client.notify("workspace/didChangeConfiguration", {
                  settings = client.config.settings,
                })
                vim.notify("LTeX language changed to " .. choice, vim.log.levels.INFO)
              end
            end)
          end

          wk.register({
            ["<leader>ly"] = {
              name = "LTeX",
              a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "LTeX Code Actions" },
              r = {
                function()
                  ltex_extra.setup({
                    load_langs = { "en-US", "en-GB", "ko" },
                    init_check = true,
                    path = vim.fn.stdpath("config") .. "/spell",
                  })
                  vim.notify("LTeX dictionaries reloaded", vim.log.levels.INFO)
                end,
                "Reload LTeX Dictionaries",
              },
              l = { change_ltex_language, "Switch language" },
              d = {
                function()
                  local current_state = client.config.settings.ltex.enabled
                  client.config.settings.ltex.enabled = not current_state
                  client.notify("workspace/didChangeConfiguration", {
                    settings = client.config.settings,
                  })
                  vim.notify("LTeX " .. (not current_state and "enabled" or "disabled"), vim.log.levels.INFO)
                end,
                "Toggle LTeX",
              },
            },
          }, { buffer = bufnr })
        end,

        settings = {
          ltex = {
            enabled = true,
            language = "en-US",
            checkFrequency = "save",
            logLevel = "severe",
            additionalRules = {
              enablePickyRules = false,
              motherTongue = "en-US",
            },
            disabledRules = {
              ["en-US"] = {
                "PROFANITY",
                "EN_QUOTES",
              },
              ["en-GB"] = {
                "PROFANITY",
                "EN_QUOTES",
              },
              ["ko"] = {},
            },
            dictionary = {
              ["en-US"] = {},
              ["en-GB"] = {},
              ["ko"] = {},
            },
            markdown = {
              nodes = {
                CodeBlock = "ignore",
                FencedCodeBlock = "ignore",
                AutoLink = "ignore",
                Link = "ignore",
                WikiLink = "ignore",
              },
            },
            diagnosticSeverity = "information",
            hiddenFalsePositives = {
              ["en-US"] = [=[
              "Alki"
              ]=],
              ["en-GB"] = [=[
              "Alki"
              ]=],
              ["ko"] = [=[
              ]=],
            },
          },
        },
        flags = {
          debounce_text_changes = 2000, -- Debounce for 2 seconds
          allow_incremental_sync = false,
        },
        init_options = {
          serverStatusNotification = true,
          documentChunkSize = 5000,
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown", "tex", "text", "mail" },
        callback = function()
          vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
            buffer = 0, -- current buffer
            callback = function()
              local clients = vim.lsp.get_active_clients({ bufnr = 0 })
              for _, client in ipairs(clients) do
                if client.name == "ltex" then
                  vim.schedule(function()
                    vim.diagnostic.show()
                  end)
                  break
                end
              end
            end,
          })
        end,
      })
    end,
  },
}
