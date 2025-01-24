-- TODO: Update python path in neotest-python adapter
return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/nvim-nio", -- Added required dependency
    -- Test adapters
    "nvim-neotest/neotest-python", -- Python support
    "nvim-neotest/neotest-plenary", -- Lua support
    "nvim-neotest/neotest-vim-test", -- Vim test integration
    "marilari88/neotest-vitest", -- Vitest support
    "haydenmeade/neotest-jest", -- Jest support
    "rouge8/neotest-rust", -- Rust support
  },
  config = function()
    -- Get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace("neotest")

    require("neotest").setup({
      -- Customize diagnostic signs
      diagnostic = {
        enabled = true,
        severity = vim.diagnostic.severity.ERROR,
      },
      -- Customize status signs
      status = {
        enabled = true,
        signs = true,
        virtual_text = false,
      },
      -- Configure adapters
      adapters = {
        require("neotest-python")({
          -- Extra arguments for nvim-dap configuration
          dap = { justMyCode = false },
          -- Command for python test runner
          runner = "pytest",
          -- Python path
          python = vim.fn.expand('~/.config/nvim/venv/neovim/bin/python3'),
        }),
        require("neotest-plenary"),
        require("neotest-vitest"),
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.ts",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        }),
        require("neotest-rust"),
        require("neotest-vim-test")({
          ignore_file_types = { "python", "vim", "lua", "javascript", "typescript" },
        }),
      },
    })

    -- Set up which-key mappings
    local wk = require("which-key")
    wk.add({
      { "<leader>t", group = "Test" },
      { "<leader>ta", "<cmd>lua require('neotest').run.attach()<cr>", desc = "Attach" },
      { "<leader>td", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "Debug Test" },
      { "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "Run File" },
      { "<leader>tl", "<cmd>lua require('neotest').run.run_last()<cr>", desc = "Run Last" },
      { "<leader>to", "<cmd>lua require('neotest').output.open({ enter = true })<cr>", desc = "Open Output" },
      { "<leader>tp", "<cmd>lua require('neotest').output_panel.toggle()<cr>", desc = "Toggle Output Panel" },
      { "<leader>ts", "<cmd>lua require('neotest').run.stop()<cr>", desc = "Stop" },
      { "<leader>tt", "<cmd>lua require('neotest').run.run()<cr>", desc = "Run Nearest" },
      { "<leader>tw", "<cmd>lua require('neotest').watch.toggle()<cr>", desc = "Toggle Watch" },
    })
  end,
}
