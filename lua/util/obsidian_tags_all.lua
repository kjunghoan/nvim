---@class ObsidianTagsAllNoteMatch
---@field path string
---@field display_name string
---@field first_line integer
---@field first_col integer|?
---@field status string|nil frontmatter `status:` scalar, nil when absent
---@field matched_tags table<string, boolean> lowercased requested tags this note satisfies

---@class ObsidianTagsAllQuery
---@field tags string[] normalized, AND-ed
---@field statuses string[] normalized, OR-ed; empty means no status filter

local STATUS_ARG_PREFIX = "status:"
local NO_STATUS_LABEL = "(none)"

---@type string[]|nil
local cached_tag_names = nil

local function workspace_dir()
  return require("obsidian.api").resolve_workspace_dir()
end

---@param found_tag string
---@param wanted_tag string
---@return boolean
local function tag_satisfies_request(found_tag, wanted_tag)
  local found = found_tag:lower()
  local wanted = wanted_tag:lower()
  return found == wanted or vim.startswith(found, wanted .. "/")
end

---@param tag_locations obsidian.TagLocation[]
---@param wanted_tags string[]
---@return ObsidianTagsAllNoteMatch[]
local function notes_matching_every_tag(tag_locations, wanted_tags)
  ---@type table<string, ObsidianTagsAllNoteMatch>
  local by_path = {}
  ---@type string[]
  local path_order = {}

  for _, loc in ipairs(tag_locations) do
    local key = tostring(loc.path)
    if by_path[key] == nil then
      local status = loc.note:get_field("status")
      by_path[key] = {
        path = key,
        display_name = loc.note:display_name(),
        first_line = loc.line,
        first_col = loc.tag_start,
        status = (type(status) == "string" and status ~= "") and status or nil,
        matched_tags = {},
      }
      path_order[#path_order + 1] = key
    end
    for _, wanted in ipairs(wanted_tags) do
      if tag_satisfies_request(loc.tag, wanted) then
        by_path[key].matched_tags[wanted:lower()] = true
      end
    end
  end

  ---@type ObsidianTagsAllNoteMatch[]
  local results = {}
  for _, key in ipairs(path_order) do
    local match = by_path[key]
    if vim.tbl_count(match.matched_tags) == #wanted_tags then
      results[#results + 1] = match
    end
  end
  return results
end

---@param note_matches ObsidianTagsAllNoteMatch[]
---@param statuses string[]
---@return ObsidianTagsAllNoteMatch[]
local function notes_with_any_status(note_matches, statuses)
  if #statuses == 0 then
    return note_matches
  end
  ---@type table<string, boolean>
  local allowed = {}
  for _, status in ipairs(statuses) do
    allowed[status:lower()] = true
  end
  return vim.tbl_filter(function(match)
    local key = match.status and match.status:lower() or NO_STATUS_LABEL
    return allowed[key] == true
  end, note_matches)
end

---@param query ObsidianTagsAllQuery
---@return string
local function picker_title(query)
  local title = "#" .. table.concat(query.tags, " ∧ #")
  if #query.statuses > 0 then
    title = title .. " · status ∈ {" .. table.concat(query.statuses, ", ") .. "}"
  end
  return title
end

---@type fun(all_matches: ObsidianTagsAllNoteMatch[], query: ObsidianTagsAllQuery)
local open_notes_picker

---@param all_matches ObsidianTagsAllNoteMatch[]
---@param query ObsidianTagsAllQuery
local function open_status_picker(all_matches, query)
  ---@type table<string, integer>
  local counts = {}
  ---@type string[]
  local order = {}
  for _, match in ipairs(all_matches) do
    local key = match.status or NO_STATUS_LABEL
    if counts[key] == nil then
      counts[key] = 0
      order[#order + 1] = key
    end
    counts[key] = counts[key] + 1
  end
  table.sort(order)

  local items = vim.tbl_map(function(key)
    return { text = string.format("%-16s %d", key, counts[key]), note_status = key }
  end, order)

  Snacks.picker.pick({
    title = "status filter for " .. picker_title({ tags = query.tags, statuses = {} }),
    items = items,
    format = "text",
    confirm = function(picker)
      local selected = picker:selected({ fallback = true })
      picker:close()
      local statuses = vim.tbl_map(function(item)
        return item.note_status
      end, selected)
      vim.schedule(function()
        open_notes_picker(all_matches, { tags = query.tags, statuses = statuses })
      end)
    end,
  })
end

open_notes_picker = function(all_matches, query)
  local visible = notes_with_any_status(all_matches, query.statuses)
  if #visible == 0 then
    require("obsidian.log").warn("No note matches " .. picker_title(query))
    return
  end

  local items = vim.tbl_map(function(match)
    return {
      text = match.display_name .. " " .. match.path,
      file = match.path,
      pos = { match.first_line, (match.first_col or 1) - 1 },
      comment = match.status,
    }
  end, visible)

  Snacks.picker.pick({
    title = picker_title(query),
    items = items,
    format = "file",
    confirm = "jump",
    cwd = tostring(workspace_dir()),
    win = {
      input = {
        keys = {
          ["<M-s>"] = { "filter_status", mode = { "n", "i" }, desc = "Filter by status" },
        },
      },
    },
    actions = {
      filter_status = function(picker)
        picker:close()
        vim.schedule(function()
          open_status_picker(all_matches, query)
        end)
      end,
    },
  })
end

---@param tag_locations obsidian.TagLocation[]
---@return string[]
local function unique_sorted_tag_names(tag_locations)
  ---@type table<string, boolean>
  local seen = {}
  ---@type string[]
  local names = {}
  for _, loc in ipairs(tag_locations) do
    if not seen[loc.tag] then
      seen[loc.tag] = true
      names[#names + 1] = loc.tag
    end
  end
  table.sort(names)
  return names
end

---@param on_choice fun(tags: string[])
local function open_tag_multiselect_picker(on_choice)
  require("obsidian.search").find_tags_async("", function(tag_locations)
    cached_tag_names = unique_sorted_tag_names(tag_locations)

    Snacks.picker.pick({
      title = "Tags (Tab to multi-select)",
      items = vim.tbl_map(function(name)
        return { text = name }
      end, cached_tag_names),
      format = "text",
      confirm = function(picker)
        local selected = picker:selected({ fallback = true })
        picker:close()
        local tags = vim.tbl_map(function(item)
          return item.text
        end, selected)
        if #tags > 0 then
          vim.schedule(function()
            on_choice(tags)
          end)
        end
      end,
    })
  end, { dir = workspace_dir() })
end

---@param raw_args string[]
---@return ObsidianTagsAllQuery
local function parse_args(raw_args)
  ---@type table<string, boolean>
  local seen_tags = {}
  ---@type string[]
  local tags = {}
  ---@type table<string, boolean>
  local seen_statuses = {}
  ---@type string[]
  local statuses = {}

  for _, raw in ipairs(raw_args) do
    if vim.startswith(raw, STATUS_ARG_PREFIX) then
      local status = raw:sub(#STATUS_ARG_PREFIX + 1)
      if status ~= "" and not seen_statuses[status:lower()] then
        seen_statuses[status:lower()] = true
        statuses[#statuses + 1] = status
      end
    else
      local tag = vim.startswith(raw, "#") and raw:sub(2) or raw
      if tag ~= "" and not seen_tags[tag:lower()] then
        seen_tags[tag:lower()] = true
        tags[#tags + 1] = tag
      end
    end
  end
  return { tags = tags, statuses = statuses }
end

---@param query ObsidianTagsAllQuery
local function search_and_pick(query)
  require("obsidian.search").find_tags_async(query.tags, function(tag_locations)
    local all_matches = notes_matching_every_tag(tag_locations, query.tags)
    open_notes_picker(all_matches, query)
  end, { dir = workspace_dir() })
end

return {

  ---@param raw_args string[]
  find_notes_with_all_tags = function(raw_args)
    local query = parse_args(raw_args or {})
    if #query.tags == 0 then
      open_tag_multiselect_picker(function(tags)
        search_and_pick({ tags = tags, statuses = query.statuses })
      end)
    else
      search_and_pick(query)
    end
  end,

  ---@param arg_lead string
  ---@return string[]
  complete_tags = function(arg_lead)
    if vim.startswith(arg_lead, STATUS_ARG_PREFIX) then
      return {}
    end
    if cached_tag_names == nil then
      require("obsidian.search").find_tags_async("", function(tag_locations)
        cached_tag_names = unique_sorted_tag_names(tag_locations)
      end, { dir = workspace_dir() })
      return {}
    end
    return vim.tbl_filter(function(name)
      return vim.startswith(name, arg_lead)
    end, cached_tag_names)
  end,
}
