-- lua/plugins/go-tools.lua
return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("go").setup({
      -- Disable LSP setup since we're handling it separately
      lsp_cfg = false,
      lsp_gofumpt = true,
      lsp_on_attach = false,
      lsp_keymaps = false,

      -- Diagnostic settings
      lsp_diag_hdlr = true,
      lsp_diag_virtual_text = { space = 0, prefix = "■" },
      lsp_diag_signs = true,
      lsp_diag_update_in_insert = false,

      -- Formatting
      goimports = 'gopls',
      gofmt = 'gofumpt',
      max_line_len = 120,
      tag_transform = false,
      tag_options = 'json=omitempty',

      -- Testing
      test_runner = 'go', -- or 'richgo', 'dlv', 'ginkgo'
      test_efm = true,
      test_timeout = '30s',
      test_env = {},
      test_template = '',
      test_template_dir = '',

      -- Build
      build_tags = 'integration',
      textobjects = true,

      -- Icons (matching your existing icon setup)
      icons = {
        breakpoint = '🔴',
        currentpos = '👉',
      },

      -- Trouble integration if you use it
      trouble = false,
      luasnip = true,

      -- Security and vulnerability checking
      run_in_floaterm = false,

      -- Auto commands
      auto_format = false,
      auto_lint = false,
    })

    -- Minimal Go-specific keybindings (LSP actions use <leader>l)
    local wk = require("which-key")
    wk.add({
      { "<leader>G",   group = "Go Tools" },

      -- Testing (Go-specific functionality)
      { "<leader>Gt",  group = "Test" },
      { "<leader>Gtr", ":GoTest<CR>",             desc = "Run Tests" },
      { "<leader>GtR", ":GoTestFunc<CR>",         desc = "Test Function" },
      { "<leader>Gtf", ":GoTestFile<CR>",         desc = "Test File" },
      { "<leader>Gta", ":GoAddTest<CR>",          desc = "Add Test" },
      { "<leader>Gtc", ":GoCoverage<CR>",         desc = "Coverage" },
      { "<leader>GtC", ":GoCoverageClear<CR>",    desc = "Clear Coverage" },
      { "<leader>Gtv", ":GoVet<CR>",              desc = "Go Vet" },

      -- Build and Run (Go-specific)
      { "<leader>Gb",  group = "Build" },
      { "<leader>Gbr", ":GoBuild<CR>",            desc = "Build" },
      { "<leader>GbR", ":GoRun<CR>",              desc = "Run" },
      { "<leader>Gbi", ":GoInstall<CR>",          desc = "Install" },

      -- Go-specific code generation
      { "<leader>Gg",  group = "Generate" },
      { "<leader>Ggt", ":GoAddTag<CR>",           desc = "Add Tags" },
      { "<leader>GgT", ":GoRmTag<CR>",            desc = "Remove Tags" },
      { "<leader>Gge", ":GoIfErr<CR>",            desc = "If Err" },
      { "<leader>Ggf", ":GoFillStruct<CR>",       desc = "Fill Struct" },
      { "<leader>GgS", ":GoFillSwitch<CR>",       desc = "Fill Switch" },

      -- Module and Dependencies (Go-specific)
      { "<leader>Gm",  group = "Module" },
      { "<leader>Gmt", ":GoModTidy<CR>",          desc = "Mod Tidy" },
      { "<leader>Gmv", ":GoModVendor<CR>",        desc = "Mod Vendor" },
      { "<leader>Gmi", ":GoModInit<CR>",          desc = "Mod Init" },

      -- Alternative files (Go-specific test/impl switching)
      { "<leader>Ga", ":GoAlt<CR>",              desc = "Alternative File" },
    })
  end,
  event = { "CmdlineEnter" },
  ft = { "go", 'gomod' },
  build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
}
