-- JDTLS diagnostic script
-- Load this in Neovim with `:luafile jdtls_diagnose.lua` to check your JDTLS setup

local function check_java()
  local java_home = os.getenv("JAVA_HOME")
  print("JAVA_HOME: " .. (java_home or "Not set"))

  local java_version = vim.fn.system("java -version 2>&1")
  print("Java version: ")
  print(java_version)
end

local function check_jdtls_installation()
  local mason_path = vim.fn.stdpath("data") .. "/mason"
  print("Mason path: " .. mason_path)

  local jdtls_path = mason_path .. "/packages/jdtls"
  local jdtls_exists = vim.fn.isdirectory(jdtls_path) == 1
  print("JDTLS path: " .. jdtls_path)
  print("JDTLS installed: " .. tostring(jdtls_exists))

  if jdtls_exists then
    local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
    print("Launcher JAR: " .. (launcher_jar ~= "" and launcher_jar or "Not found"))

    -- Check config directories
    local config_linux = jdtls_path .. "/config_linux"
    local config_mac = jdtls_path .. "/config_mac"
    local config_win = jdtls_path .. "/config_win"

    print("Linux config exists: " .. tostring(vim.fn.isdirectory(config_linux) == 1))
    print("Mac config exists: " .. tostring(vim.fn.isdirectory(config_mac) == 1))
    print("Windows config exists: " .. tostring(vim.fn.isdirectory(config_win) == 1))
  end
end

local function check_root_detection()
  local markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }

  print("Looking for Java project markers:")
  for _, marker in ipairs(markers) do
    local found = vim.fn.findfile(marker, ".;") ~= "" or vim.fn.finddir(marker, ".;") ~= ""
    print("  " .. marker .. ": " .. tostring(found))
  end

  local root_dir = vim.fs.root(0, markers)
  print("Detected root dir: " .. (root_dir or "None"))
end

local function check_lsp_config()
  -- Check if vim.lsp.enable is available
  local lsp_enable_exists = type(vim.lsp.enable) == "function"
  print("vim.lsp.enable exists: " .. tostring(lsp_enable_exists))

  -- Check if lsp/jdtls.lua exists
  local config_path = vim.fn.stdpath("config") .. "/lsp/jdtls.lua"
  local config_exists = vim.fn.filereadable(config_path) == 1
  print("jdtls.lua exists: " .. tostring(config_exists))

  if config_exists then
    print("jdtls.lua path: " .. config_path)
  end
end

print("=== JDTLS Diagnostic Report ===\n")
print("--- Java Check ---")
check_java()
print("\n--- JDTLS Installation Check ---")
check_jdtls_installation()
print("\n--- Project Root Check ---")
check_root_detection()
print("\n--- LSP Config Check ---")
check_lsp_config()
print("\n=== End of Report ===")
