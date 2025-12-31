-- https://github.com/Ramilito/kubectl.nvim
return {
  "Ramilito/kubectl.nvim",
  dependencies = { "saghen/blink.download" },
  cmd = { "Kubectl", "Kubectx", "Kubens" },
  keys = {
    { "<leader>k", '<cmd>lua require("kubectl").toggle()<cr>', desc = "Toggle Kubectl" },
  },
  config = function()
    require("kubectl").setup({
      namespace = "All",
    })

    -- Smart helm path detection
    local helm_paths = {
      "/home/linuxbrew/.linuxbrew/bin/helm",
      vim.fn.exepath("helm"),
    }

    for _, path in ipairs(helm_paths) do
      if path ~= "" and vim.fn.executable(path) == 1 then
        local helm_def = require("kubectl.resources.helm")
        if helm_def and helm_def.definition then
          helm_def.definition.cmd = path
        end
        break
      end
    end
  end,
}
