-- lsp/gopls.lua
return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = {
    "go.work",
    "go.mod",
    ".git",
  },
  settings = {
    gopls = {
      -- Experimental features
      experimentalPostfixCompletions = true,
      experimentalUseInvalidMetadata = true,
      experimentalWatchedFileDelay = "100ms",

      -- Analysis settings
      analyses = {
        unusedparams = true,
        unreachable = true,
        fillstruct = true,
        nonewvars = true,
        undeclaredname = true,
        unusedwrite = true,
        useany = true,
      },

      -- Code lens
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },

      -- Completion settings
      completeUnimported = true,
      completionDocumentation = true,
      deepCompletion = true,

      -- Formatting
      gofumpt = true, -- Use gofumpt for stricter formatting

      -- Import organization
      ["local"] = "", -- Set this to your module prefix for local imports

      -- Hover settings
      hoverKind = "FullDocumentation",

      -- Inlay hints (great for understanding Go code)
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },

      -- Link target
      linkTarget = "pkg.go.dev",

      -- Navigation settings
      linksInHover = true,

      -- Semantic tokens
      semanticTokens = true,

      -- Static check integration
      staticcheck = true,

      -- Symbol settings
      symbolMatcher = "FastFuzzy",
      symbolStyle = "Dynamic",

      -- Vulncheck settings for security
      vulncheck = "Imports", -- Check for known vulnerabilities

      -- Build settings for better performance
      buildFlags = { "-tags", "integration" },
      env = {
        GOFLAGS = "-tags=integration",
      },

      -- Directory filters (exclude common dirs you don't want analyzed)
      directoryFilters = {
        "-node_modules",
        "-vendor",
        "-.git",
        "-.vscode",
        "-.idea",
        "-.vscode-test",
        "-testdata",
      },
    },
  },

  on_attach = function(client, bufnr)
    -- Enable inlay hints if available (Neovim 0.10+)
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    -- Go-specific keymaps using which-key
    local wk = require("which-key")
    wk.add({
      { "<leader>lyg",  group = "Go" },
      {
        "<leader>lygi",
        function()
          vim.lsp.buf.code_action({
            context = {
              only = { "source.organizeImports" },
              diagnostics = vim.diagnostic.get(bufnr)
            },
            apply = true,
          })
        end,
        desc = "Organize Imports"
      },
      {
        "<leader>lygt",
        function()
          vim.lsp.buf.code_action({
            context = {
              only = { "source.test" },
              diagnostics = {}
            },
            apply = true,
          })
        end,
        desc = "Generate Tests"
      },
      {
        "<leader>lygf",
        function()
          vim.lsp.buf.code_action({
            context = {
              only = { "source.fillstruct" },
              diagnostics = {}
            },
            apply = true,
          })
        end,
        desc = "Fill Struct"
      },
      {
        "<leader>lygs",
        function()
          vim.lsp.buf.code_action({
            context = {
              only = { "source.switch" },
              diagnostics = {}
            },
            apply = true,
          })
        end,
        desc = "Switch if/else"
      },
      { "<leader>lygv", ":!go mod vendor<CR>", desc = "Go Mod Vendor" },
      { "<leader>lygm", ":!go mod tidy<CR>",   desc = "Go Mod Tidy" },
    }, { buffer = bufnr })
  end,

  single_file_support = true,
}
