return {
  'Ramilito/kubectl.nvim',
  dependencies = { "saghen/blink.download", },
  config = function()
    require("kubectl").setup({
      kubectl_cmd = { 
        cmd = "kubectl",
        env = {
          KUBECONFIG = vim.fn.expand("~/.kube/config")
        }
      }
    })
    -- Override helm command path
    local helm_def = require("kubectl.resources.helm")
    if helm_def and helm_def.definition then
      helm_def.definition.cmd = "/home/linuxbrew/.linuxbrew/bin/helm"
    end
  end,
  namespace = "All",
  cmd = { 'Kubectl', 'Kubectx', 'Kubens' },
  keys = {
    { '<leader>k', '<cmd>lua require("kubectl").toggle()<cr>' },
    { "<C-t>",     "<Plug>(kubectl.view_top)",                ft = "k8s_*" },
    { "<C-k>",     "<Plug>(kubectl.kill)",                    ft = "k8s_*" },
    { "7",         "<Plug>(kubectl.view_nodes)",              ft = "k8s_*" },
    { "8",         "<Plug>(kubectl.view_events)",             ft = "k8s_*" },
    { "9",         "<Plug>(kubectl.view_pv)",                 ft = "k8s_*" },
    { "0",         "<Plug>(kubectl.view_helm)",               ft = "k8s_*" },
    { "<F2>",      "<Plug>(kubectl.view_api_resources)",      ft = "k8s_*" },
    { "<F3>",      "<Plug>(kubectl.view_crds)",               ft = "k8s_*" },
    { "<F4>",      "<Plug>(kubectl.view_cronjobs)",           ft = "k8s_*" },
    { "<F5>",      "<Plug>(kubectl.view_pvc)",                ft = "k8s_*" },
  },
}
