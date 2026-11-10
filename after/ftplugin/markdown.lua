local function enclosing_node_of_type(node_type)
  local node = vim.treesitter.get_node()
  while node and node:type() ~= node_type do
    node = node:parent()
  end
  return node
end

local function last_nonblank_line_at_or_before(line_number)
  while line_number > 1 and vim.fn.getline(line_number):match("^%s*$") do
    line_number = line_number - 1
  end
  return line_number
end

local function line_range_of_node(node)
  local start_row, _, end_row, end_column = node:range()
  local first_line = start_row + 1
  local last_line = end_column == 0 and end_row or end_row + 1
  return first_line, last_nonblank_line_at_or_before(last_line)
end

local function code_block_or_section_line_range(include_edges)
  local code_block = enclosing_node_of_type("fenced_code_block")
  if code_block then
    local first_line, last_line = line_range_of_node(code_block)
    if include_edges then
      return first_line, last_line
    end
    return first_line + 1, last_line - 1
  end

  local section = enclosing_node_of_type("section")
  if section then
    local first_line, last_line = line_range_of_node(section)
    if include_edges then
      return first_line, last_line
    end
    return first_line + 1, last_line
  end
end

local function select_code_block_or_section(include_edges)
  local first_line, last_line = code_block_or_section_line_range(include_edges)
  if not first_line or first_line > last_line then
    return
  end
  if vim.fn.mode():match("^[vV\22]") then
    vim.cmd("normal! \27")
  end
  vim.cmd(("normal! %dGV%dG"):format(first_line, last_line))
end

vim.keymap.set({ "x", "o" }, "ai", function()
  select_code_block_or_section(true)
end, { buffer = true, desc = "Code block or section" })

vim.keymap.set({ "x", "o" }, "ii", function()
  select_code_block_or_section(false)
end, { buffer = true, desc = "Inside code block or section" })
