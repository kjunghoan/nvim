---@class ObsidianLinkEntry
---@field link string raw link text as written in the note
---@field resolved_path string|nil

---@param link string
---@return string|nil
local function resolve_link_to_path(link)
  local obsidian_util = require("obsidian.util")
  local location = obsidian_util.parse_link(link)
  if not location or obsidian_util.is_uri(location) then
    return nil
  end
  location = vim.uri_decode(location) or location
  location = obsidian_util.strip_block_links(location)
  location = obsidian_util.strip_anchor_links(location)
  if location == "" then
    return nil
  end

  if require("obsidian.attachment").is_attachment_path(location) then
    return require("obsidian.link").resolve_link_path(location)
  end

  local matching_note = require("obsidian.search").resolve_note(location)[1]
  return matching_note and tostring(matching_note.path) or nil
end

---@param message string
---@return obsidian.ui_select_preview_spec
local function placeholder_preview(message)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "wipe"
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { message })
  return { buf = buf }
end

---@param entry ObsidianLinkEntry
---@return obsidian.ui_select_preview_spec
local function preview_link_entry(entry)
  if entry.resolved_path then
    return require("obsidian.util").preview_path(entry.resolved_path)
  end
  return placeholder_preview("unresolved or external link: " .. entry.link)
end

local M = {}

function M.pick_links_with_preview()
  local current_note = require("obsidian.api").current_note(0)
  if not current_note then
    return require("obsidian.log").info("not in a note")
  end

  ---@type ObsidianLinkEntry[]
  local entries = vim.tbl_map(function(match)
    return { link = match.link, resolved_path = resolve_link_to_path(match.link) }
  end, current_note:links())

  require("obsidian.picker").select(entries, {
    prompt = "Links",
    format_item = function(entry)
      return entry.link
    end,
    preview_item = preview_link_entry,
  }, function(choices)
    local chosen = choices[1]
    if chosen then
      require("obsidian.actions").follow_link(chosen.link)
    end
  end)
end

return M
