-- https://github.com/rest-nvim/rest.nvim
local plain_lua_dependency_names = { "xml2lua", "lua-mimetypes" }

vim.pack.add({
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/j-hui/fidget.nvim",
  "https://github.com/manoelcampos/xml2lua",
  "https://github.com/lunarmodules/lua-mimetypes",
})

for _, plugin_data in ipairs(vim.pack.get(plain_lua_dependency_names, { info = false })) do
  package.path = table.concat({ package.path, plugin_data.path .. "/?.lua" }, ";")
end


vim.pack.add({ "https://github.com/rest-nvim/rest.nvim" })

vim.keymap.set("n", "<leader>rr", "<cmd>Rest run<cr>", { desc = "Run Request" })
vim.keymap.set("n", "<leader>rl", "<cmd>Rest last<cr>", { desc = "Run Last" })
vim.keymap.set("n", "<leader>re", "<cmd>Rest env select<cr>", { desc = "Env Select" })
vim.keymap.set("n", "<leader>ry", "<cmd>Rest curl yank<cr>", { desc = "Yank curl" })
vim.keymap.set("n", "<leader>rc", "<cmd>Rest cookies<cr>", { desc = "Cookies" })
vim.keymap.set("n", "<leader>rL", "<cmd>Rest logs<cr>", { desc = "Logs" })
