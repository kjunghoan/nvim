-- YAML language server configuration
return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yml" },
  root_markers = { ".git" },
  settings = {
    yaml = {
      schemaStore = {
        -- Enable schema store for automatic schema detection
        -- Includes GitHub Actions, GitLab CI, Kubernetes, and many others
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      schemas = {
        -- CI/CD
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*.{yml,yaml}",
        ["https://json.schemastore.org/gitlab-ci.json"] = "/.gitlab-ci.{yml,yaml}",

        -- Docker
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.{yml,yaml}",

        -- Kubernetes
        ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.31.0/all.json"] = "k8s/**/*.{yml,yaml}",
        kubernetes = "*.k8s.{yml,yaml}",
      },
      validate = true,
      hover = true,
      completion = true,
      format = {
        enable = true,
      },
    },
  },
}
