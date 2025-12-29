-- OpenTofu language server configuration
return {
  cmd = { "tofu-ls", "serve" },
  filetypes = { "terraform", "tf" },
  root_markers = { ".terraform", ".git" },
  settings = {
    ["terraform-ls"] = {
      experimentalFeatures = {
        validateOnSave = true,
        prefillRequiredFields = true,
      },
    },
  },
  capabilities = {
    textDocument = {
      signatureHelp = {
        dynamicRegistration = true,
        signatureInformation = {
          documentationFormat = { "markdown", "plaintext" },
          parameterInformation = {
            labelOffsetSupport = true,
          },
          activeParameterSupport = true,
        },
        contextSupport = true,
      },
    },
  },
}
