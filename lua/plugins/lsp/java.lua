return {
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local function jdtls_setup(event)
        local jdtls = require("jdtls")
        local wk = require("which-key")

        -- Get the current OS
        local os_config = "linux"
        if vim.fn.has("mac") == 1 then
          os_config = "mac"
        end

        -- Find root directory (find .git directory)
        local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
        local root_dir = require("jdtls.setup").find_root(root_markers)
        if root_dir == "" then
          return
        end

        local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
        local workspace_dir = vim.fn.expand("~/.cache/jdtls/workspace/") .. project_name

        -- Main Config
        -- Get the mason path and verify jdtls installation
        local lombok_path =
          "/home/kjunghoan/.gradle/caches/modules-2/files-2.1/org.projectlombok/lombok/1.18.30/f195ee86e6c896ea47a1d39defbe20eb59cd149d/lombok-1.18.30.jar"
        local mason_registry = require("mason-registry")
        local jdtls_pkg = mason_registry.get_package("jdtls")

        if not jdtls_pkg:is_installed() then
          print("JDTLS is not installed. Installing...")
          jdtls_pkg:install()
        end

        -- Get bundles for debugging and testing support
        local bundles = {
          vim.fn.glob(
            "/home/kjunghoan/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
            1
          ),
        }
        vim.list_extend(
          bundles,
          vim.split(vim.fn.glob("/home/kjunghoan/.local/share/nvim/mason/packages/java-test/extension/server/*.jar", 1), "\\n")
        )

        local jdtls_path = jdtls_pkg:get_install_path()
        local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

        if launcher_jar == "" then
          print("Failed to find JDTLS launcher jar. Please check your installation.")
          return
        end

        local config = {
          cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xmx1g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens",
            "java.base/java.util=ALL-UNNAMED",
            "--add-opens",
            "java.base/java.lang=ALL-UNNAMED",
            "-jar",
            launcher_jar,
            "-configuration",
            jdtls_path .. "/config_" .. os_config,
            "-data",
            workspace_dir,
          },
          root_dir = root_dir,
          settings = {
            java = {
              signatureHelp = { enabled = true },
              contentProvider = { preferred = "fernflower" },
              completion = {
                favoriteStaticMembers = {
                  "org.hamcrest.MatcherAssert.assertThat",
                  "org.hamcrest.Matchers.*",
                  "org.junit.Assert.*",
                  "org.junit.Assume.*",
                  "org.junit.jupiter.api.Assertions.*",
                  "org.junit.jupiter.api.Assumptions.*",
                  "org.junit.jupiter.api.DynamicContainer.*",
                  "org.junit.jupiter.api.DynamicTest.*",
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
                hashCodeEquals = {
                  useJava7Objects = true,
                },
                useBlocks = true,
              },
              configuration = {
                runtimes = {
                  {
                    name = "JavaSE-17",
                    path = "/home/linuxbrew/.linuxbrew/Cellar/openjdk@17/17.0.13/libexec", -- Linuxbrew Java path
                  },
                },
              },
            },
          },
          init_options = {
            bundles = {},
            extendedClientCapabilities = {
              progressReportProvider = true,
              classFileContentsSupport = true,
              generateToStringPromptSupport = true,
              hashCodeEqualsPromptSupport = true,
              advancedExtractRefactoringSupport = true,
              advancedOrganizeImportsSupport = true,
              generateConstructorsPromptSupport = true,
              generateDelegateMethodsPromptSupport = true,
              moveRefactoringSupport = true,
              overrideMethodsPromptSupport = true,
              executeClientCommandSupport = true,
            },
          },
        }

        local wk = require("which-key")
        wk.register({
          ["<leader>lyj"] = {
            name = "Java",
            i = {
              function()
                require("jdtls").organize_imports()
              end,
              "Organize Imports",
            },
            t = {
              function()
                require("jdtls").test_class()
              end,
              "Test Class",
            },
            n = {
              function()
                require("jdtls").test_nearest_method()
              end,
              "Test Method",
            },
            v = {
              name = "Extract Variable",
              n = {
                function()
                  require("jdtls").extract_variable()
                end,
                "Extract Variable (normal)",
              },
              v = {
                function()
                  require("jdtls").extract_variable_all()
                end,
                "Extract Variable (visual)",
              },
            },
            c = {
              function()
                require("jdtls").extract_constant()
              end,
              "Extract Constant",
            },
            m = {
              function()
                require("jdtls").extract_method()
              end,
              "Extract Method",
            },
          },
        })

        jdtls.start_or_attach(config)
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = jdtls_setup,
      })
    end,
  },
}
