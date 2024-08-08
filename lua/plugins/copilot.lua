return {
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

      -- Set the keymap to toggle Copilot with <C-c-o>
      vim.keymap.set("n", "<leader>co", toggle_copilot, { noremap = true, silent = true })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      -- { "zbirenbaum/copilot.lua" }, -- or the one below
      {"github/copilot.vim"},
      { "nvim-lua/plenary.nvim" },  -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
