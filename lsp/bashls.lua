return {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash', 'zsh' },
  root_markers = {
    '.git',
    '.bashrc',
    '.bash_profile',
    'package.json',
    '.shellcheckrc',
  },
  settings = {
    bashIde = {
      -- pattern matchers
      globPattern = "*@(.sh|.inc|.bash|.command|.zsh)",
      shellcheckPath = "shellcheck",
      enableShellcheckAnalysis = true,
      includeAllWorkspaceSymbols = true,
      explainshellEndpoint = "" -- if I want to set up an explainshell instance
    },
  },
  single_file_support = true,
  on_attach = function(client, bufnr)
    -- formatting
    client.server_capabililies.documentFormattingProvider = true

    vim.keymap.set('n', '<leader>lyb', function()
      vim.lsp.buf.code_action({
        context = {
          diagnostics = vim.diagnostic.get(bufnr)
        },
      })
    end, { buffer = bufnr, desc = "Bash Code Actions" })
  end
}
