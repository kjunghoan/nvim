local IDENTIFY_FORMAT = table.concat({
  "format=%m",
  "geometry=%wx%h",
  "depth=%z-bit",
  "colorspace=%[colorspace]",
  "resolution=%xx%y %U",
  "filesize=%b",
  "%[*]",
}, "\n")

---@param buf integer
local function keep_buffer_unmodified(buf)
  vim.api.nvim_create_autocmd("BufModifiedSet", {
    buffer = buf,
    callback = function()
      if vim.bo[buf].modified then
        vim.bo[buf].modified = false
      end
    end,
  })
  vim.bo[buf].modified = false
end

---@param path string
---@return string
local function identify_target_for_path(path)
  if path:lower():match("%.pdf$") then
    return path .. "[0]"
  end
  return path
end

---@param path string
---@param lines string[]
local function open_metadata_float(path, lines)
  Snacks.win({
    title = " " .. vim.fn.fnamemodify(path, ":t") .. " ",
    text = lines,
    ft = "dosini",
    width = 0.7,
    height = 0.8,
    border = "rounded",
    fixbuf = true,
    wo = { wrap = false },
    bo = { modifiable = false },
    keys = { q = "close" },
  })
end

---@param buf integer
local function show_image_metadata(buf)
  local path = vim.api.nvim_buf_get_name(buf)
  local command = { "magick", "identify", "-format", IDENTIFY_FORMAT, identify_target_for_path(path) }
  vim.system(command, { text = true }, function(result)
    vim.schedule(function()
      if result.code ~= 0 then
        Snacks.notify.error("identify failed: " .. vim.trim(result.stderr or ""))
        return
      end
      open_metadata_float(path, vim.split(result.stdout or "", "\n", { trimempty = true }))
    end)
  end)
end

local M = {}

function M.register_autocmd()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "image",
    group = vim.api.nvim_create_augroup("util.image_buffer", { clear = true }),
    callback = function(event)
      keep_buffer_unmodified(event.buf)
      vim.keymap.set("n", "K", function()
        show_image_metadata(event.buf)
      end, { buffer = event.buf, silent = true, desc = "Image metadata" })
    end,
  })
end

return M
