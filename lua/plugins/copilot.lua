return { -- my current plugin
  {
    "github/copilot.vim",

    config = function()
      -- Initially disable Copilot
      vim.cmd("Copilot disable")
      vim.g.copilot_enabled = false

      local function toggle_copilot()
        vim.g.copilot_enabled = false
        -- Checking if Copilot is already enabled
        if vim.g.copilot_enabled then
          -- Copilot is enabled, so disable it
          vim.cmd("Copilot disable")
          vim.g.copilot_enabled = false
          print("Copilot disabled")
        else
          -- Copilot is disabled, so enable it
          vim.cmd("Copilot enable")
          vim.g.copilot_enabled = true
          print("Copilot enabled")
        end
      end
      local wk = require("which-key")
      wk.register({
        c = {
          name = "copilot",
          o = { toggle_copilot, "Toggle Copilot" }
        }
      }, { prefix = "<leader>" })
      -- Set the keymap to toggle Copilot with <C-c-o>
      -- vim.keymap.set("n", "<leader>co", toggle_copilot, { noremap = true, silent = true })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest (https://github.com/jellydn/lazy-nvim-ide/blob/main/lua/plugins/extras/copilot-chat-v2.lua)
      question_header = '### User',
      answer_header = '### Copilot',
      error_header = '### Error',
      prompts = {
        -- Code Related Prompts
        Explain = "Please explain how the following code works",
        Review = "Please review the following code and provide suggestions for improvement",
        Refactor = "Please refactor the following code to improve its clarity and readability",
        Optimize = "Please optimize the following code to improve its performance",
        UnitTest = "Please write a unit test for the following code",
        IntegrationTest = "Please write an integration test for the following code",
        FixCode = "Please fix the following code to make it work as intended",
        FixError = "Please explain the error in the following code and provide a solution",
        SwaggerApiDocs = "Please provide documentation for the following API using Swagger",
        SwaggerJsDocs = "Please write JSDoc comments for the following code using Swagger",
        Documentation = "Please provide documentation for the following code",

        -- Text Related Prompts
        Summarize = "Please summarize the following text",
        Spelling = "Please correct any spelling or grammatical errors in the following text",
        Wording = "Please imporve the wording and grammar of the following text",
        Consistency = "Please ensure that the following text is consistent in style and tone",
        Conciseness = "Please rewrite the following text to be more concise",
      },
      auto_follow_cursor = false, -- Don't follow the cursor after getting a response
      show_help = true,           -- TODO: Change to false to disable help message
      mappings = {
        complete = {
          detail = "Use @<Tab> or /<Tab> for options.",
          insert = "<Tab>",
        },
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        reset = {
          normal = "<C-x>",
          insert = "<C-x>",
        },
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-CR>",
        },
        accept_diff = {
          normal = "<C-y>",
          insert = "<C-y>",
        },
        yank_diff = {
          normal = "gmy",
        },
        show_diff = {
          normal = "gmd",
        },
        show_system_prompt = {
          normal = "gmp",
        },
        show_user_selection = {
          normal = "gms",
        },
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      local select = require("CopilotChat.select")
      opts.selection = select.unnamed

      local user = vim.env.USER or "User"
      user = user:sub(1, 1):upper() .. user:sub(2)
      opts.question_header = "  " .. user .. " "
      opts.answer_header = "  Copilot "

      chat.setup(opts)
      require("CopilotChat.integrations.cmp").setup()

      vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
        chat.ask(args.args, { selection = select.visual })
      end, { nargs = "*", range = true })

      vim.api.nvim_create_user_command("CopilotChatInline", function(args)
        chat.ask(args.args, {
          selection = select.visual,
          window = {
            layout = "float",
            relative = "cursor",
            width = 1,
            height = 0.4,
            row = 1,
          },
        })
      end, { nargs = "*", range = true })

      vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
        chat.ask(args.args, { selection = select.buffer })
      end, { nargs = "*", range = true })

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-*",
        callback = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = true

          local ft = vim.bo.filetype
          if ft == "copilot-chat" then
            vim.bo.filetype = "markdown"
          end
        end,
      })
      local wk = require("which-key")
      wk.register({
        c = {
          name = "Copilot Chat",
          c = { "<cmd>CopilotChatVisual<cr>", "Copilot Chat (Visual)" },
          i = { "<cmd>CopilotChatInline<cr>", "Copilot Chat (Inline)" },
          b = { "<cmd>CopilotChatBuffer<cr>", "Copilot Chat (Buffer)" },
          d = { "<cmd>CopilotChatShowDiff<cr>", "Show Diff" },
          p = { "<cmd>CopilotChatShowSystemPrompt<cr>", "Show System Prompt" },
          s = { "<cmd>CopilotChatShowUserSelection<cr>", "Show User Selection" },
          r = { "<cmd>CopilotChatReset<cr>", "Reset Chat" },
          q = { "<cmd>CopilotChatClose<cr>", "Close Chat" },
        },
      }, { prefix = "<leader>c" })
    end,
    event = "VeryLazy",
    -- See Commands section for default commands if you want to lazy load on them
  },
}
