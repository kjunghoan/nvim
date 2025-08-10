return {
  "mfussenegger/nvim-jdtls",
  ft = { "java" },
  dependencies = {},
  config = function()
    local function jdtls_setup()
      local jdtls = require("jdtls")
      local wk = require("which-key")

      -- Get the current OS
      local os_config = "linux"
      if vim.fn.has("mac") == 1 then
        os_config = "mac"
      end

      -- Find root directory
      local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
      local root_dir = require("jdtls.setup").find_root(root_markers)
      if not root_dir then
        return
      end

      local function find_java_home()
        local java_home = os.getenv("JAVA_HOME")

        -- Check if JAVA_HOME is valid
        if java_home and vim.fn.isdirectory(java_home) == 1 then
          return java_home
        end

        -- Based on your specific setup
        local homebrew_path = "/home/linuxbrew/.linuxbrew/Cellar/openjdk@21/21.0.6/libexec"
        if vim.fn.isdirectory(homebrew_path) == 1 then
          return homebrew_path
        end

        -- Fallback to whatever JAVA_HOME is, even if invalid
        return java_home or ""
      end

      local java_home = find_java_home()
      -- print("Using Java home: " .. java_home)

      local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
      local workspace_dir = vim.fn.expand("~/.cache/jdtls/workspace/") .. project_name

      -- Main Config
      local mason_path = vim.fn.stdpath("data") .. "/mason"
      local jdtls_path = mason_path .. "/packages/jdtls"

      -- Get bundles for debugging and testing support
      local bundles = {
        vim.fn.glob(mason_path .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
          true),
      }
      vim.list_extend(bundles,
        vim.split(vim.fn.glob(mason_path .. "/packages/java-test/extension/server/*.jar", true), "\n"))

      -- Additional JVM args (declare this FIRST)
      local java_args = {
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx2g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
      }

      -- Find Lombok jar with improved logic for Gradle projects
      local project_lombok_paths = {
        -- Check the project's Gradle cache first
        root_dir .. "/.gradle/caches/modules-2/files-2.1/org.projectlombok/lombok/*/lombok-*.jar",
        -- Check for Gradle build folder
        root_dir .. "/build/dependencies/lombok-*.jar",
        -- Check in project libs directory
        root_dir .. "/lib/lombok*.jar",
        root_dir .. "/libs/lombok*.jar",
        -- Check for Maven local repository paths
        vim.fn.expand("$HOME/.gradle/caches/modules-2/files-2.1/org.projectlombok/lombok/*/lombok-*.jar"),
        vim.fn.expand("$HOME/.m2/repository/org/projectlombok/lombok/*/lombok-*.jar"),
        -- Explicitly check for a specific version as fallback
        vim.fn.expand("$HOME/.m2/repository/org/projectlombok/lombok/1.18.30/lombok-1.18.30.jar"),
        -- Check in a globally available location
        "/usr/local/share/lombok/lombok.jar",
        "/usr/share/lombok/lombok.jar",
      }

      local lombok_path = ""
      for _, path in ipairs(project_lombok_paths) do
        local found_path = vim.fn.glob(path)
        if found_path ~= "" then
          lombok_path = found_path
          break
        end
      end

      if lombok_path == "" then
        -- If no lombok jar found, attempt to download one
        -- print("Lombok JAR not found. Attempting to download...")

        -- Create directory if needed
        local lombok_dir = vim.fn.expand("~/.local/share/lombok")
        if vim.fn.isdirectory(lombok_dir) == 0 then
          vim.fn.mkdir(lombok_dir, "p")
        end

        -- Attempt to download the lombok jar if it doesn't exist
        local download_path = lombok_dir .. "/lombok.jar"
        if vim.fn.filereadable(download_path) == 0 then
          local cmd = "curl -s -L https://projectlombok.org/downloads/lombok.jar -o " .. download_path
          vim.fn.system(cmd)

          -- Check if download was successful
          if vim.fn.filereadable(download_path) == 1 then
            lombok_path = download_path
            -- print("Downloaded Lombok JAR to: " .. lombok_path)
          else
            -- print("Failed to download Lombok JAR.")
            -- print("Lombok features may not work correctly.")
            -- print("You may need to build your project first to download dependencies.")
          end
        else
          lombok_path = download_path
          -- print("Using previously downloaded Lombok JAR: " .. lombok_path)
        end
      end

      if lombok_path ~= "" then
        -- print("Using Lombok JAR: " .. lombok_path)
        table.insert(java_args, "-javaagent:" .. lombok_path)
      end

      local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

      if launcher_jar == "" then
        -- print("Failed to find JDTLS launcher jar. Please check your installation.")
        return
      end

      -- Configuration for nvim-jdtls
      local config = {
        cmd = {
          "/usr/lib/jvm/java-21-openjdk-amd64/bin/java",
          unpack(java_args),
          "-jar", launcher_jar,
          "-configuration", jdtls_path .. "/config_" .. os_config,
          "-data", workspace_dir,
        },
        root_dir = root_dir,
        settings = {
          java = {
            eclipse = { downloadSources = true },
            configuration = {
              updateBuildConfiguration = "interactive",
              runtimes = {
                {
                  name = "JavaSE-21",
                  path = java_home,
                  default = true,
                },
              },
            },
            maven = { downloadSources = true },
            implementationsCodeLens = { enabled = true },
            referencesCodeLens = { enabled = true },
            format = { enabled = true },
            signatureHelp = { enabled = true },
            contentProvider = { preferred = "fernflower" },
            -- Lombok configuration at root level of java settings
            lombok = {
              enabled = true,
            },
            -- Enable annotation processing
            compiler = {
              annotationProcessing = {
                enabled = true,
              },
            },
            completion = {
              favoriteStaticMembers = {
                "org.junit.Assert.*",
                "org.junit.Assume.*",
                "org.junit.jupiter.api.Assertions.*",
                "org.junit.jupiter.api.Assumptions.*",
                "org.junit.jupiter.api.DynamicContainer.*",
                "org.junit.jupiter.api.DynamicTest.*",
                "org.mockito.Mockito.*",
              },
              importOrder = { "java", "javax", "com", "org" },
            },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
          },
        },
        init_options = {
          bundles = bundles,
        },
        on_attach = function(_, bufnr)
          -- Register keybindings after the LSP attaches
          wk.register({
            ["<leader>lyj"] = {
              name = "Java",
              i = { function() jdtls.organize_imports() end, "Organize Imports" },
              t = { function() jdtls.test_class() end, "Test Class" },
              n = { function() jdtls.test_nearest_method() end, "Test Method" },
              v = {
                name = "Extract Variable",
                n = { function() jdtls.extract_variable() end, "Extract Variable (normal)" },
                v = { function() jdtls.extract_variable_all() end, "Extract Variable (visual)" },
              },
              c = { function() jdtls.extract_constant() end, "Extract Constant" },
              m = { function() jdtls.extract_method() end, "Extract Method" },
            },
          }, { buffer = bufnr })

          -- print("JDTLS attached to buffer: " .. bufnr)
        end,
      }

      -- Special handling for Neovim 0.11
      -- This ensures nvim-jdtls doesn't interfere with vim.lsp.enable()
      vim.schedule(function()
        -- Get the current buffer number
        local current_buf = vim.api.nvim_get_current_buf()
        -- print("JDTLS setup for buffer: " .. current_buf)

        -- Check if JDTLS is already attached by vim.lsp.enable()
        local clients = vim.lsp.get_clients({ bufnr = current_buf, name = "jdtls" })
        if #clients > 0 then
          -- If already attached, stop the client before reattaching
          -- print("Found existing JDTLS client(s). Stopping before reattaching...")
          for _, client in ipairs(clients) do
            client:stop()
          end
        end

        -- Start nvim-jdtls with enhanced configuration
        -- print("Starting JDTLS for Java file...")
        jdtls.start_or_attach(config)

        -- Verify attachment after a short delay
        vim.defer_fn(function()
          local attached_clients = vim.lsp.get_clients({ bufnr = current_buf })
          local client_names = {}
          for _, client in ipairs(attached_clients) do
            table.insert(client_names, client.name)
          end
          -- print("Attached LSP clients: " .. table.concat(client_names, ", "))
        end, 1000)
      end)
    end

    -- Set up autocommand to attach JDTLS
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      callback = jdtls_setup,
    })
  end,
}
