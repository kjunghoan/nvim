return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  config = function()
    local jdtls = require("jdtls")

    local function find_java_home()
      local java_home = os.getenv("JAVA_HOME")
      if java_home then
        return java_home
      end

      local handle = io.popen("ls -d /home/linuxbrew/.linuxbrew/Cellar/openjdk@*/*/libexec/openjdk.jdk/Contents/Home 2>/dev/null | head -1")
      if handle then
        local result = handle:read("*a")
        handle:close()
        if result and result ~= "" then
          return result:gsub("%s+", "")
        end
      end

      return "/usr/lib/jvm/default-java"
    end

    local function find_lombok_jar()
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
      local lombok_path = mason_path .. "/lombok.jar"

      if vim.fn.filereadable(lombok_path) == 1 then
        return lombok_path
      end

      local handle = io.popen("find ~/.m2 -name 'lombok*.jar' 2>/dev/null | head -1")
      if handle then
        local result = handle:read("*a")
        handle:close()
        if result and result ~= "" then
          return result:gsub("%s+", "")
        end
      end

      vim.notify("Lombok not found, downloading...", vim.log.levels.INFO)
      vim.fn.system(string.format(
        "curl -L https://projectlombok.org/downloads/lombok.jar -o %s",
        lombok_path
      ))
      return lombok_path
    end

    local java_home = find_java_home()
    local lombok_jar = find_lombok_jar()

    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = vim.fn.stdpath("data") .. "/eclipse-workspace/" .. project_name

    local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"

    local bundles = {}

    local java_debug_path = vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extension/server"
    if vim.fn.isdirectory(java_debug_path) == 1 then
      vim.list_extend(
        bundles,
        vim.split(vim.fn.glob(java_debug_path .. "/com.microsoft.java.debug.plugin-*.jar"), "\n")
      )
    end

    local java_test_path = vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server"
    if vim.fn.isdirectory(java_test_path) == 1 then
      vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/*.jar"), "\n"))
    end

    local config = {
      cmd = {
        java_home .. "/bin/java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-javaagent:" .. lombok_jar,
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        vim.fn.glob(mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
        "-configuration",
        mason_path .. "/config_linux",
        "-data",
        workspace_dir,
      },
      root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
      settings = {
        java = {
          eclipse = {
            downloadSources = true,
          },
          configuration = {
            updateBuildConfiguration = "interactive",
          },
          maven = {
            downloadSources = true,
          },
          implementationsCodeLens = {
            enabled = true,
          },
          referencesCodeLens = {
            enabled = true,
          },
          references = {
            includeDecompiledSources = true,
          },
          format = {
            enabled = true,
            settings = {
              url = vim.fn.stdpath("config") .. "/lang-servers/intellij-java-google-style.xml",
              profile = "GoogleStyle",
            },
          },
          signatureHelp = { enabled = true },
          completion = {
            favoriteStaticMembers = {
              "org.hamcrest.MatcherAssert.assertThat",
              "org.hamcrest.Matchers.*",
              "org.hamcrest.CoreMatchers.*",
              "org.junit.jupiter.api.Assertions.*",
              "java.util.Objects.requireNonNull",
              "java.util.Objects.requireNonNullElse",
              "org.mockito.Mockito.*",
            },
            filteredTypes = {
              "com.sun.*",
              "io.micrometer.shaded.*",
              "java.awt.*",
              "jdk.*",
              "sun.*",
            },
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
          codeGeneration = {
            toString = {
              template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
          },
        },
      },
      flags = {
        allow_incremental_sync = true,
      },
      init_options = {
        bundles = bundles,
      },
    }

    config.capabilities = vim.lsp.protocol.make_client_capabilities()

    local function stop_existing_jdtls_clients()
      local clients = vim.lsp.get_clients({ name = "jdtls" })
      for _, client in ipairs(clients) do
        client:stop()
      end
    end

    stop_existing_jdtls_clients()

    vim.defer_fn(function()
      jdtls.start_or_attach(config)

      vim.keymap.set("n", "<leader>lo", function()
        require("jdtls").organize_imports()
      end, { buffer = true, desc = "Organize Imports" })

      vim.keymap.set("n", "<leader>lv", function()
        require("jdtls").extract_variable()
      end, { buffer = true, desc = "Extract Variable" })

      vim.keymap.set("v", "<leader>lv", function()
        require("jdtls").extract_variable(true)
      end, { buffer = true, desc = "Extract Variable" })

      vim.keymap.set("n", "<leader>lc", function()
        require("jdtls").extract_constant()
      end, { buffer = true, desc = "Extract Constant" })

      vim.keymap.set("v", "<leader>lc", function()
        require("jdtls").extract_constant(true)
      end, { buffer = true, desc = "Extract Constant" })

      vim.keymap.set("v", "<leader>lm", function()
        require("jdtls").extract_method(true)
      end, { buffer = true, desc = "Extract Method" })

      vim.keymap.set("n", "<leader>df", function()
        require("jdtls").test_nearest_method()
      end, { buffer = true, desc = "Debug Method" })

      vim.keymap.set("n", "<leader>dT", function()
        require("jdtls").test_class()
      end, { buffer = true, desc = "Debug Class" })

      vim.keymap.set("n", "<leader>ru", function()
        require("jdtls").update_project_config()
      end, { buffer = true, desc = "Update Project Config" })

      vim.keymap.set("n", "<leader>tc", function()
        require("jdtls").test_class()
      end, { buffer = true, desc = "Test Class" })

      vim.keymap.set("n", "<leader>tm", function()
        require("jdtls").test_nearest_method()
      end, { buffer = true, desc = "Test Method" })
    end, 100)
  end,
}
