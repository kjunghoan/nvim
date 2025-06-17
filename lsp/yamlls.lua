return {
  cmd = { 'yaml-language-server', '--stdio' },
  filetypes = { 'yaml' },
  root_markers = {
    '.git',
    'docker-compose.yml',
    'docker-compose.yaml',
    'kustomization.yml',
    'kustomization.yaml',
    'Chart.yaml', -- Helm charts
  },
  settings = {
    yaml = {
      -- Basic YAML settings
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

      -- Schema configuration - only the essentials that actually work
      schemas = {
        -- Docker Compose - matches docker-compose files specifically
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
          "docker-compose*.yml",
          "docker-compose*.yaml",
          "compose*.yml",
          "compose*.yaml",
        },

        -- Kubernetes - matches k8s manifests by common patterns
        ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.29.0-standalone-strict/all.json"] = {
          "k8s/**/*.yml",
          "k8s/**/*.yaml",
          "kubernetes/**/*.yml",
          "kubernetes/**/*.yaml",
          "manifests/**/*.yml",
          "manifests/**/*.yaml",
          -- Common k8s file naming patterns
          "**/deployment*.yml",
          "**/deployment*.yaml",
          "**/service*.yml",
          "**/service*.yaml",
          "**/configmap*.yml",
          "**/configmap*.yaml",
          "**/secret*.yml",
          "**/secret*.yaml",
          "**/ingress*.yml",
          "**/ingress*.yaml",
          "**/pod*.yml",
          "**/pod*.yaml",
          "**/namespace*.yml",
          "**/namespace*.yaml",
        },

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
      },

      -- Enable schemastore for additional schemas
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },

      -- Custom tags (add more as needed)
      customTags = {
        -- Common custom tags you might encounter
        "!include scalar",
        "!include_dir_named mapping",
        "!include_dir_list sequence",
        "!secret scalar",
      },
    }
  },

  -- Better root detection for different project types
  on_new_config = function(_, root_dir)
    -- Auto-detect project type and adjust schemas accordingly
    local project_type = "generic"

    -- Check for docker-compose project
    if vim.fn.glob(root_dir .. "/docker-compose*.yml") ~= "" or
        vim.fn.glob(root_dir .. "/docker-compose*.yaml") ~= "" then
      project_type = "docker-compose"
    end

    -- Check for k8s project
    if vim.fn.isdirectory(root_dir .. "/k8s") == 1 or
        vim.fn.isdirectory(root_dir .. "/kubernetes") == 1 or
        vim.fn.isdirectory(root_dir .. "/manifests") == 1 or
        vim.fn.glob(root_dir .. "/kustomization.y*ml") ~= "" then
      project_type = "kubernetes"
    end

    -- Check for helm project
    if vim.fn.glob(root_dir .. "/Chart.yaml") ~= "" then
      project_type = "helm"
    end

    -- You could adjust settings based on project type here if needed
    -- For now, we'll just log it for debugging
    -- vim.notify("YAML LSP detected project type: " .. project_type, vim.log.levels.INFO)
  end,

  capabilities = vim.tbl_deep_extend("force",
    vim.lsp.protocol.make_client_capabilities(),
    {
      textDocument = {
        completion = {
          completionItem = {
            snippetSupport = true
          }
        }
      }
    }
  ),

  single_file_support = true,
}
