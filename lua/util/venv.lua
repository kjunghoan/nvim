local M = {}

function M.find_project_venv()
  local cwd = vim.fn.getcwd()

  local exact_names = {
    "venv",
    ".venv",
    "env",
    ".env",
    "virtualenv",
    ".virtualenv",
  }

  for _, name in ipairs(exact_names) do
    local venv_path = cwd .. "/" .. name .. "/bin/python3"
    if vim.fn.executable(venv_path) == 1 then
      return venv_path
    end
  end

  local patterns = { "env", "venv", "virtualenv" }
  local dirs = vim.fn.glob(cwd .. "/*", false, true)

  if type(dirs) == "table" then
    for _, dir in ipairs(dirs) do
      if vim.fn.isdirectory(dir) == 1 then
        local dir_name = vim.fn.fnamemodify(dir, ":t")
        for _, pattern in ipairs(patterns) do
          if dir_name:match(pattern) then
            local python_path = dir .. "/bin/python3"
            if vim.fn.executable(python_path) == 1 then
              return python_path
            end
          end
        end
      end
    end
  end

  local parent = vim.fn.fnamemodify(cwd, ":h")
  while parent ~= "/" and parent ~= vim.fn.expand("~") do
    for _, name in ipairs(exact_names) do
      local venv_path = parent .. "/" .. name .. "/bin/python3"
      if vim.fn.executable(venv_path) == 1 then
        return venv_path
      end
    end
    parent = vim.fn.fnamemodify(parent, ":h")
  end

  return vim.fn.expand("~/.config/nvim/venv/neovim/bin/python3")
end

return M
