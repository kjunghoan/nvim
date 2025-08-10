return {
  'Ramilito/kubectl.nvim',
  config = function()
    require("kubectl").setup()
  end,
  cmd = { 'Kubectl', 'Kubectx', 'Kubens' },
  keys = {
    { '<leader>k', '<cmd>lua require("kubectl").toggle()<cr>' },
  },
  init = function()
    local group = vim.api.nvim_create_augroup("kubectl_custom_mappings", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = "k8s_*",
      callback = function(ev)
        local k = vim.keymap.set
        local opts = { buffer = ev.buf }

        k("n", "<C-t>", "<Plug>(kubectl.view_top)", opts)
        k("n", "<C-k>", "<Plug>(kubectl.kill)", opts)
        k("n", "7", "<Plug>(kubectl.view_nodes)", opts)

        k("n", "8", "<Plug>(kubectl.view_events)", opts)
        k("n", "9", "<Plug>(kubectl.view_pv)", opts)
        -- k("n", "0", "<Plug>(kubectl.view_helm)", opts)

        k("n", "<F2>", "<Plug>(kubectl.view_api_resources)", opts)
        k("n", "<F3>", "<Plug>(kubectl.view_crds)", opts)
        k("n", "<F4>", "<Plug>(kubectl.view_cronjobs)", opts)
        k("n", "<F5>", "<Plug>(kubectl.view_pvc)", opts)
        -- k("n", "9", "<Plug>(kubectl.view_sa)", opts)
        -- k("n", "9", "<Plug>(kubectl.view_overview)", opts)
      end
    })
  end,
}
