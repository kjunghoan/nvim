vim.ui.open = function(path)
  local cmd = { "lemonade" }
  local host = os.getenv("LEMONADE_HOST")
  local port = os.getenv("LEMONADE_PORT")

  if host then
    table.insert(cmd, "--host=" .. host)
  end
  if port then
    table.insert(cmd, "--port=" .. port)
  end

  table.insert(cmd, "open")
  table.insert(cmd, path)

  vim.fn.jobstart(cmd, { detach = true })
end
