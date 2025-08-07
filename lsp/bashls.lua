return {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash', 'zsh' },
  root_markers = {
    '.git',
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
  -- on_attach = function(client)
  --   -- formatting
  --   client.server_capabilities.documentFormattingProvider = true
  -- end
}
