-- https://github.com/tailwindlabs/tailwindcss-intellisense
-- Tailwind CSS class completion / linting
return {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = {
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
  },
  workspace_required = true,
  root_dir = function(bufnr, on_dir)
    local tailwind_root = vim.fs.root(bufnr, function(name, path)
      if name:match("^tailwind%.config%.[cm]?[jt]s$") then
        return true
      end
      if name ~= "package.json" then
        return false
      end
      local package_json = vim.fs.joinpath(path, name)
      for _, line in ipairs(vim.fn.readfile(package_json)) do
        if line:find('"tailwindcss"', 1, true) then
          return true
        end
      end
      return false
    end)
    if tailwind_root then
      on_dir(tailwind_root)
    end
  end,
}
