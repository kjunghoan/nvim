-- https://github.com/neovim/nvim-lspconfig
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

local binary_for_server = {
  bashls = "bash-language-server",
  copilot = "copilot-language-server",
  cssls = "vscode-css-language-server",
  docker_language_server = "docker-language-server",
  eslint = "vscode-eslint-language-server",
  gopls = "gopls",
  jdtls = "jdtls",
  jsonls = "vscode-json-language-server",
  just = "just-lsp",
  lua_ls = "lua-language-server",
  markdown_oxide = "markdown-oxide",
  nil_ls = "nil",
  postgres_lsp = "postgres-language-server",
  pyright = "pyright-langserver",
  ruby_lsp = "ruby-lsp",
  ruff = "ruff",
  rust_analyzer = "rust-analyzer",
  tailwindcss = "tailwindcss-language-server",
  texlab = "texlab",
  tinymist = "tinymist",
  tofu_ls = "tofu-ls",
  ts_ls = "typescript-language-server",
  yamlls = "yaml-language-server",
}

local servers_with_binary_on_path = {}
local servers_missing_binary = {}
for server, binary in pairs(binary_for_server) do
  if vim.fn.executable(binary) == 1 then
    servers_with_binary_on_path[#servers_with_binary_on_path + 1] = server
  else
    servers_missing_binary[#servers_missing_binary + 1] = server
  end
end
table.sort(servers_missing_binary)

vim.lsp.enable(servers_with_binary_on_path)

local function server_handles_filetype(server, filetype)
  local filetypes = vim.lsp.config[server].filetypes
  return filetypes == nil or vim.list_contains(filetypes, filetype)
end

local servers_already_warned_about = {}

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user-lsp-missing-binary", { clear = true }),
  callback = function(event)
    local newly_missing = {}
    for _, server in ipairs(servers_missing_binary) do
      if
        not servers_already_warned_about[server]
        and server_handles_filetype(server, event.match)
      then
        servers_already_warned_about[server] = true
        newly_missing[#newly_missing + 1] = server
      end
    end
    if #newly_missing > 0 then
      vim.notify("LSP not on PATH: " .. table.concat(newly_missing, ", "), vim.log.levels.WARN)
    end
  end,
})

vim.lsp.inlay_hint.enable(false)

vim.keymap.set("n", "<leader>lh", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })

vim.lsp.inline_completion.enable(true)

vim.keymap.set("n", "<leader>ct", function()
  local should_enable = not vim.lsp.inline_completion.is_enabled()
  vim.lsp.inline_completion.enable(should_enable)
  vim.notify("Copilot suggestions " .. (should_enable and "on" or "off"))
end, { desc = "Toggle Copilot suggestions" })

vim.keymap.set("i", "<C-M-l>", function() vim.lsp.inline_completion.get() end, { desc = "Accept inline completion" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
  callback = function(event)
    vim.keymap.set(
      "n",
      "gd",
      vim.lsp.buf.definition,
      { buffer = event.buf, desc = "Go to definition" }
    )
  end,
})
