-- https://github.com/bezhermoso/tree-sitter-ghostty
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(event)
    local changed_plugin = event.data
    if changed_plugin.spec.name ~= "tree-sitter-ghostty" then
      return
    end
    if changed_plugin.kind ~= "install" and changed_plugin.kind ~= "update" then
      return
    end
    local build_result = vim.system({ "make", "nvim_install" }, { cwd = changed_plugin.path }):wait()
    if build_result.code ~= 0 then
      vim.notify("tree-sitter-ghostty build failed: " .. (build_result.stderr or ""), vim.log.levels.ERROR)
    end
  end,
})

vim.pack.add({ "https://github.com/bezhermoso/tree-sitter-ghostty" })
