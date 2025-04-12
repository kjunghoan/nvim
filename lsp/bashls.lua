return {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash', 'zsh' },
  root_markers = {
    '.git',
    'package.json',
    '.shellcheckrc',
  },
  settings = {
    bashIde = {
      -- pattern matchers
      globPattern = "*@(.sh|.inc|.bash|.command|.zsh)",
      shellcheckPath = "shellcheck",
      enableShellcheckAnalysis = true,
      includeAllWorkspaceSymbols = false,
      shellcheckArgs = { "--external-sources", "--severity=warning", "--shell=bash" },
      explainshellEndpoint = "" -- if I want to set up an explainshell instance
    },
  },
  single_file_support = true,
  on_attach = function(client, bufnr)
    -- formatting
    client.server_capabilities.documentFormattingProvider = true

    vim.keymap.set('n', '<leader>lyb', function()
      vim.lsp.buf.code_action({
        context = {
          diagnostics = vim.diagnostic.get(bufnr)
        },
      })
    end, { buffer = bufnr, desc = "Bash Code Actions" })
  end
}
