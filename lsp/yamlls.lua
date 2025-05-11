return {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = {
    'yaml',
    'yaml.docker-compose', -- Special filetype for docker-compose
    'yaml.ansible'         -- Special filetype for ansible
  },
  root_markers = {
    '.git',
    '.yamllint',
    '.yamllint.yaml',
    '.yamllint.yml',
    'docker-compose.yaml',
    'docker-compose.yml'
  },
  settings = {
    yaml = {
      -- Enable both YAML 1.1 and 1.2 schemas
      yamlVersion = "1.2",

      -- Configure format options
      format = {
        enable = true,
        singleQuote = false,
        bracketSpacing = true,
        proseWrap = "preserve",
        printWidth = 120,
      },

      -- Configure validation features
      validate = true,

      -- Show hover information
      hover = true,

      -- Enable completion
      completion = true,

      -- Schema configuration - define schemas for different YAML files
      schemas = {
        -- Kubernetes schemas
        ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/master-standalone/all.json"] =
        "/*-k8s.yaml",

        ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.27.3-standalone-strict/all.json"] = {
          "*.k8s.yaml",
          "kubernetes/*.yaml",
          "k8s/*.yaml",
        },

        -- Docker Compose schema
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
        "docker-compose*.{yml,yaml}",

        -- GitHub Workflows
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",

        -- GitHub Actions
        ["https://json.schemastore.org/github-action.json"] = "/.github/actions/*/action.{yml,yaml}",

        -- CircleCI schema
        ["https://json.schemastore.org/circleciconfig.json"] = "/.circleci/config.{yml,yaml}",

        -- GitLab CI schema
        ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] =
        "/.gitlab-ci.{yml,yaml}",

        -- Kustomization schema
        ["https://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}",
      },

      -- Automatically pull schema information from schemastore.org
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },

      -- Controls whether the YAML language server uses the built-in Kubernetes schema
      disableDefaultProperties = false,

      -- Defines custom tags for the parser to use
      customTags = {
        -- Uncomment and customize as needed:
        -- "!include_dir_named",
        -- "!secret"
      },
    }
  },

  -- Disable specific capabilities if you have conflicts with other extensions
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true
        }
      }
    }
  },

  -- We can support single files without a project
  single_file_support = true,
}
