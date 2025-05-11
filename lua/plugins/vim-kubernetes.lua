-- Replace vimkubectl with vim-kubernetes
return {
  "andrewstuart/vim-kubernetes",
  config = function()
    local wk = require("which-key")
    wk.add({
      { "<leader>k", group = "Kubernetes" },
      { "<leader>ka", ":KubeApply<CR>", desc = "Apply Current File" },
      { "<leader>kg", ":Kubectl get ", desc = "Get Resources" },
      { "<leader>kd", ":Kubectl describe ", desc = "Describe Resource" },
    })
  end
}
