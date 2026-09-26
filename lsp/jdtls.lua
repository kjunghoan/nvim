-- https://github.com/eclipse-jdtls/eclipse.jdt.ls
return {
  cmd = function(dispatchers, config)
    local root = config.root_dir or vim.fn.getcwd()
    local workspace_dir = vim.fs.joinpath(vim.fn.stdpath("cache"), "jdtls", vim.fn.sha256(root):sub(1, 16) .. "-" .. vim.fs.basename(root))
    return vim.lsp.rpc.start({ "jdtls", "-data", workspace_dir }, dispatchers)
  end,
  filetypes = { "java" },
  root_markers = {
    "build.gradle",
    "build.gradle.kts",
    "settings.gradle",
    "settings.gradle.kts",
    "pom.xml",
    "mvnw",
    "gradlew",
    ".git",
  },
}
