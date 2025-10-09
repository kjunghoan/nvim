if os.getenv("TMUX") then
  vim.g.clipboard = {
    name = "tmux",
    copy = {
      ["+"] = { "tmux", "load-buffer", "-" },
      ["*"] = { "tmux", "load-buffer", "-" },
    },
    paste = {
      ["+"] = { "tmux", "save-buffer", "-" },
      ["*"] = { "tmux", "save-buffer", "-" },
    },
    cache_enabled = true,
  }
elseif vim.fn.executable("lemonade") == 1 then
  vim.g.clipboard = {
    name = "lemonade",
    copy = {
      ["+"] = "lemonade copy",
      ["*"] = "lemonade copy",
    },
    paste = {
      ["+"] = "lemonade paste",
      ["*"] = "lemonade paste",
    },
    cache_enabled = true,
  }
end

vim.ui.open = function(path)
  local cmd = { 'lemonade' }
  local host = os.getenv("LEMONADE_HOST")
  local port = os.getenv("LEMONADE_PORT")

  if host then
    table.insert(cmd, '--host=' .. host)
  end
  if port then
    table.insert(cmd, '--port=' .. port)
  end

  table.insert(cmd, 'open')
  table.insert(cmd, path)

  vim.fn.jobstart(cmd, { detach = true })
end
