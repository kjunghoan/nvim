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

        -- Find root directory
        local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
        local root_dir = require("jdtls.setup").find_root(root_markers)
        if root_dir == "" then
          return
        end

        local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
        local workspace_dir = vim.fn.expand("~/.cache/jdtls/workspace/") .. project_name

        -- Main Config
        local mason_path = vim.fn.stdpath("data") .. "/mason"
        local jdtls_path = mason_path .. "/packages/jdtls"

        -- Get bundles for debugging and testing support
        local bundles = {
          vim.fn.glob(mason_path .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", 1),
        }
        vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. "/packages/java-test/extension/server/*.jar", 1), "\n"))

        local lombok_path = vim.fn.expand(
          "$HOME/.gradle/caches/modules-2/files-2.1/org.projectlombok/lombok/1.18.30/f195ee86e6c896ea47a1d39defbe20eb59cd149d/lombok-1.18.30.jar"
        )

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
            "-Xmx2g",
            "-Xms100m",
            "-XX:+UseParallelGC",
            "-XX:GCTimeRatio=4",
            "-XX:AdaptiveSizePolicyWeight=90",
            "-Dsun.zip.disableMemoryMapping=true",
            "--add-modules=ALL-SYSTEM",
            "--add-opens=java.base/java.util=ALL-UNNAMED",
            "--add-opens=java.base/java.lang=ALL-UNNAMED",
            "--add-opens=java.base/sun.nio.fs=ALL-UNNAMED",
            "--add-opens=java.base/java.io=ALL-UNNAMED",
            "--add-exports=jdk.compiler/com.sun.tools.javac.api=ALL-UNNAMED",
            "--add-exports=jdk.compiler/com.sun.tools.javac.file=ALL-UNNAMED",
            "--add-exports=jdk.compiler/com.sun.tools.javac.main=ALL-UNNAMED",
            "--add-exports=jdk.compiler/com.sun.tools.javac.model=ALL-UNNAMED",
            "--add-exports=jdk.compiler/com.sun.tools.javac.parser=ALL-UNNAMED",
            "--add-exports=jdk.compiler/com.sun.tools.javac.processing=ALL-UNNAMED",
            "--add-exports=jdk.compiler/com.sun.tools.javac.tree=ALL-UNNAMED",
            "--add-exports=jdk.compiler/com.sun.tools.javac.util=ALL-UNNAMED",
            "-javaagent:" .. lombok_path,
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
              eclipse = {
                downloadSources = true,
              },
              configuration = {
                updateBuildConfiguration = "interactive",
                runtimes = {
                  {
                    name = "JavaSE-21",
                    path = os.getenv("JAVA_HOME") .. "/libexec",
                    default = true,
                  },
                },
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
                  url = jdtls_path .. "/formatter.xml",
                },
              },
              -- Specify Lombok support
              lombok = {
                enabled = true,
              },
              -- Enable annotation processing
              compiler = {
                annotationProcessing = {
                  enabled = true,
                },
              },
              -- Important completion settings
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
                  "org.mockito.Mockito.*",
                  "org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*",
                  "org.springframework.test.web.servlet.result.MockMvcResultMatchers.*",
                },
                filteredTypes = {
                  "com.sun.*",
                  "io.micrometer.shaded.*",
                  "java.awt.*",
                  "jdk.*",
                  "sun.*",
                },
                importOrder = {
                  "java",
                  "javax",
                  "com",
                  "org",
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
              -- Enable gradle
              import = {
                gradle = {
                  enabled = true,
                  wrapper = {
                    enabled = true,
                  },
                  annotationProcessing = {
                    enabled = true,
                  },
                },
              },
              -- Enable build tool support
              project = {
                referencedLibraries = {
                  "lib/**/*.jar",
                },
                resourceFilters = {
                  "node_modules",
                  ".git",
                  "build",
                  ".gradle",
                },
              },
              -- Enable null analysis
              settings = {
                java = {
                  compile = {
                    nullAnalysis = {
                      mode = "automatic",
                    },
                  },
                  saveActions = {
                    organizeImports = true,
                  },
                  format = {
                    enabled = true,
                  },
                },
              },
            },
          },
          init_options = {
            bundles = bundles,
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
          capabilities = {
            workspace = {
              configuration = true,
            },
            textDocument = {
              completion = {
                completionItem = {
                  snippetSupport = true,
                },
              },
            },
          },
        }

        -- Register keybindings
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
