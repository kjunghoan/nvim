-- Java Development Tools Language Server (jdtls) configuration

local mason_path = vim.fn.stdpath("data") .. "/mason"
local jdtls_path = mason_path .. "/packages/jdtls"
local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

-- Determine OS-specific configuration
local os_config = "linux"
if vim.fn.has("mac") == 1 then
  os_config = "mac"
elseif vim.fn.has("win32") == 1 then
  os_config = "win"
end

local workspace_dir = vim.fn.expand("~/.cache/jdtls/workspace/default")
return {
  -- Command to start the language server
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.level=ALL",
    "-Xms512m",
    "-Xmx2g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", launcher_jar,
    "-configuration", jdtls_path .. "/config_" .. os_config,
    "-data", workspace_dir,
  },

  -- File types this server handles
  filetypes = { "java" },

  -- Project root markers - STRICTER version
  root_markers = {
    "mvnw",
    "gradlew",
    "pom.xml",
    "build.gradle",
    ".classpath",
    ".project"
  },


  -- Initialize the LSP client with proper capabilities
  init_options = {
    bundles = {},
  },

  -- Basic settings for Java
  settings = {
    java = {
      -- Download sources for better hover documentation
      eclipse = {
        downloadSources = true,
      },
      -- Configuration settings
      configuration = {
        updateBuildConfiguration = "interactive",
        -- Set your Java runtime (adjust as needed)
        runtimes = {
          {
            name = "JavaSE-21",
            path = os.getenv("JAVA_HOME"),
            default = true,
          },
        },
      },
      -- Enable code lenses for better navigation
      references = {
        includeDecompiledSources = true,
      },
      -- Format settings
      format = {
        enabled = true,
      },
      -- Enable completion settings
      completion = {
        favoriteStaticMembers = {
          "org.junit.Assert.*",
          "org.junit.Assume.*",
          "org.junit.jupiter.api.Assertions.*",
          "org.junit.jupiter.api.Assumptions.*",
          "org.mockito.Mockito.*",
        },
      },
    },
  },
  -- Single file support (basic functionality without a project)
  single_file_support = true,
}
