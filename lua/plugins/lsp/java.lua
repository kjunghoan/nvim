return {
  {
    "mfussenegger/nvim-jdtls",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    ft = { "java" },
    config = function()
      -- Ensure jdtls is installed via mason
      local mason_registry = require("mason-registry")
      if not mason_registry.is_installed("jdtls") then
        vim.notify("Installing jdtls...", vim.log.levels.INFO)
        mason_registry.get_package("jdtls"):install()
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- Custom attach function for Java
      local function on_attach(client, bufnr)
        local wk = require("which-key")
        wk.add({
          { "<leader>lyji", function() require("jdtls").organize_imports() end, desc = "Organize Imports" },
          { "<leader>lyjt", function() require("jdtls").test_class() end, desc = "Test Class" },
          { "<leader>lyjn", function() require("jdtls").test_nearest_method() end, desc = "Test Method" },
          { "<leader>lyjc", function() require("jdtls").extract_constant() end, desc = "Extract Constant" },
          { "<leader>lyjm", function() require("jdtls").extract_method() end, desc = "Extract Method" },
          -- Variable extraction submenu
          { "<leader>lyjv", group = "Extract Variable" },
          { "<leader>lyjvn", function() require("jdtls").extract_variable() end, desc = "Extract Variable (normal)" },
          { "<leader>lyjvv", function() require("jdtls").extract_variable_all() end, desc = "Extract Variable (visual)" },
        })
      end

      -- Function to find root directory
      local function find_root_dir()
        local util = require("lspconfig.util")
        return util.root_pattern("pom.xml", "build.gradle", ".git")(vim.fn.expand("%:p"))
      end

      -- Get the mason install path for jdtls
      local install_path = require("mason-registry").get_package("jdtls"):get_install_path()
      local lombok_path =
        "/home/kjunghoan/.gradle/caches/modules-2/files-2.1/org.projectlombok/lombok/1.18.30/f195ee86e6c896ea47a1d39defbe20eb59cd149d/lombok-1.18.30.jar"

      -- Setup JDTLS config directories
      local config_dir = vim.fn.stdpath("cache") .. "/jdtls/config"
      local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace"

      -- Create directories if they don't exist
      vim.fn.mkdir(config_dir, "p")
      vim.fn.mkdir(workspace_dir, "p")

      -- Setup JDTLS
      local config = {
        cmd = {
          "jdtls",
          "-configuration",
          config_dir,
          "-data",
          workspace_dir,
        },
        root_dir = find_root_dir(),
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          java = {
            configuration = {
              updateBuildConfiguration = "automatic",
              maven = {
                downloadSources = true,
              },
              gradle = {
                downloadSources = true,
                enabled = true,
              },
            },
            eclipse = {
              downloadSources = true,
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
            },
            -- Lombok support
            completion = {
              favoriteStaticMembers = {
                "org.junit.Assert.*",
                "org.junit.Assume.*",
                "org.junit.jupiter.api.Assertions.*",
                "org.junit.jupiter.api.Assumptions.*",
                "org.junit.jupiter.api.DynamicContainer.*",
                "org.junit.jupiter.api.DynamicTest.*",
                "org.assertj.core.api.Assertions.*",
                "lombok.Getter",
                "lombok.Setter",
                "lombok.Builder",
                "lombok.Data",
                "lombok.Value",
                "lombok.extern.slf4j.Slf4j",
              },
            },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
            signatureHelp = { enabled = true },
          },
        },
        init_options = {
          bundles = { lombok_path },
        },
      }

      -- Start JDTLS
      require("jdtls").start_or_attach(config)
    end,
  },
}
