return {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml' },
  root_markers = {
    '.git',
    'docker-compose.yml',
    'docker-compose.yaml',
    'kustomization.yml',
    'kustomization.yaml',
    'Chart.yaml',
  },
  settings = {
    yaml = {
      yamlVersion = "1.2",
      format = {
        enable = true,
        singleQuote = false,
        bracketSpacing = true,
        printWidth = 120,
      },
      validate = true,
      hover = true,
      completion = true,

      -- Let yamlls auto-detect based on file content
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },

      -- Only the most specific, non-conflicting schemas
      schemas = {
        -- Kustomization files
        ["https://json.schemastore.org/kustomization.json"] = {
          "kustomization.yml",
          "kustomization.yaml",
        },

        -- GitHub Workflows
        ["https://json.schemastore.org/github-workflow.json"] = {
          ".github/workflows/*.yml",
          ".github/workflows/*.yaml",
        },

        -- GitHub Actions
        ["https://json.schemastore.org/github-action.json"] = {
          ".github/actions/*/action.yml",
          ".github/actions/*/action.yaml",
        },

        -- Docker Compose
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
          "docker-compose*.yml",
          "docker-compose*.yaml",
          "compose*.yml",
          "compose*.yaml",
        },
      },

      customTags = {
        "!include scalar",
        "!secret scalar",
      },
    }
  },

  single_file_support = true,
}
