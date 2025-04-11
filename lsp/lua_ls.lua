return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markets = {
    ".git",
    ".luarc.json",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml"
  },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace ={
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    }
  },
}
