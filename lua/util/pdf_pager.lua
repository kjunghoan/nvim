---@class PdfPagerState
---@field path string
---@field current_page integer 1-indexed
---@field page_count integer|nil nil when ghostscript could not count pages

---@type table<integer, PdfPagerState>
local state_by_buf = {}

---@param path string
---@return string
local function escape_postscript_string(path)
  return (path:gsub("[\\()]", "\\%0"))
end

---@param path string
---@return integer|nil
local function count_pdf_pages(path)
  local postscript = ("(%s) (r) file runpdfbegin pdfpagecount = quit"):format(escape_postscript_string(path))
  local ok, result = pcall(function()
    return vim.system({ "gs", "-q", "-dNODISPLAY", "-dNOSAFER", "-c", postscript }, { text = true }):wait(5000)
  end)
  if not ok or result.code ~= 0 then
    return nil
  end
  return tonumber(vim.trim(result.stdout or ""))
end

---@param buf integer
local function render_page_indicator(buf)
  local state = state_by_buf[buf]
  if not state then
    return
  end
  local indicator = ("page %d/%s"):format(state.current_page, state.page_count or "?")
  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    vim.wo[win].winbar = "%=" .. indicator .. "%="
  end
end

---@param buf integer
local function render_current_page(buf)
  local state = state_by_buf[buf]
  Snacks.image.placement.clean(buf)
  Snacks.image.placement.new(buf, state.path .. "#page=" .. state.current_page, {
    conceal = true,
    auto_resize = true,
  })
  render_page_indicator(buf)
end

---@param buf integer
---@param target_page integer
local function go_to_page(buf, target_page)
  local state = state_by_buf[buf]
  local last_page = state.page_count or math.huge
  local clamped_page = math.max(1, math.min(target_page, last_page))
  if clamped_page == state.current_page then
    return
  end
  state.current_page = clamped_page
  render_current_page(buf)
end

---@param buf integer
local function attach_page_keymaps(buf)
  local map = function(keys, action, desc)
    vim.keymap.set("n", keys, action, { buffer = buf, silent = true, desc = desc })
  end
  map("l", function()
    go_to_page(buf, state_by_buf[buf].current_page + vim.v.count1)
  end, "PDF next page")
  map("h", function()
    go_to_page(buf, state_by_buf[buf].current_page - vim.v.count1)
  end, "PDF previous page")
  map("gg", function()
    go_to_page(buf, vim.v.count > 0 and vim.v.count or 1)
  end, "PDF first page / [count] page")
  map("G", function()
    local state = state_by_buf[buf]
    go_to_page(buf, vim.v.count > 0 and vim.v.count or state.page_count or state.current_page)
  end, "PDF last page / [count] page")
end

---@param buf integer
local function attach_pdf_pager(buf)
  if state_by_buf[buf] then
    return
  end
  local path = vim.api.nvim_buf_get_name(buf)
  state_by_buf[buf] = { path = path, current_page = 1, page_count = count_pdf_pages(path) }
  attach_page_keymaps(buf)
  render_page_indicator(buf)

  vim.api.nvim_create_autocmd("BufWinEnter", {
    buffer = buf,
    callback = function()
      render_page_indicator(buf)
    end,
  })
  vim.api.nvim_create_autocmd("BufWipeout", {
    buffer = buf,
    once = true,
    callback = function()
      state_by_buf[buf] = nil
    end,
  })
end

local M = {}

function M.register_autocmd()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "image",
    group = vim.api.nvim_create_augroup("util.pdf_pager", { clear = true }),
    callback = function(event)
      if vim.api.nvim_buf_get_name(event.buf):lower():match("%.pdf$") then
        attach_pdf_pager(event.buf)
      end
    end,
  })
end

return M
