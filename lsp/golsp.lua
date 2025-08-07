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

    -- Go-specific actions available through general code actions (gra / <leader>la)
  end,

  single_file_support = true,
}
