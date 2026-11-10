-- https://github.com/obsidian-nvim/obsidian.nvim
local local_config = package.loaded["local-config"]
local workspaces = type(local_config) == "table" and local_config.obsidian_workspaces or {}

if #workspaces == 0 then
  vim.notify(
    "No Obsidian workspaces configured. Create local-config.lua to add workspaces.",
    vim.log.levels.WARN
  )
  return
end

vim.pack.add({
  { src = "https://github.com/obsidian-nvim/obsidian.nvim", version = vim.version.range("*") },
})

local function note_id_from_title(title)
  local suffix = ""
  if title ~= nil then
    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
  else
    for _ = 1, 4 do
      suffix = suffix .. tostring(math.random(0, 9))
    end
  end
  return tostring(os.time()) .. "-" .. suffix
end

require("obsidian").setup({
  legacy_commands = false,
  workspaces = workspaces,
  ui = { enable = false },
  notes_subdir = "notes",
  note_id_func = note_id_from_title,
  templates = { folder = "templates" },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_user_command("ObsidianTagsAll", function(command)
  require("util.obsidian_tags_all").find_notes_with_all_tags(command.fargs)
end, {
  nargs = "*",
  complete = function(argument_lead)
    return require("util.obsidian_tags_all").complete_tags(argument_lead)
  end,
  desc = "Find notes carrying every given tag",
})

local function map_normal(keys, action, description)
  vim.keymap.set("n", keys, action, { silent = true, desc = description })
end

local function map_visual(keys, action, description)
  vim.keymap.set("v", keys, action, { silent = true, desc = description })
end

map_normal("<leader>oD", "<cmd>Obsidian dailies<CR>", "List daily Notes")
map_normal("<leader>oh", "<cmd>Obsidian help<CR>", "Help")
map_normal("<leader>on", "<cmd>Obsidian new<CR>", "New Note")
map_normal("<leader>oo", "<cmd>Obsidian open<CR>", "Open in Obsidian")
map_normal("<leader>od", "<cmd>Obsidian today<CR>", "Open Today Note")
map_normal("<leader>o[", "<cmd>Obsidian yesterday<CR>", "Open Yesterday Note")
map_normal("<leader>o]", "<cmd>Obsidian tomorrow<CR>", "Open Tomorrow Note")
map_normal("<leader>of", "<cmd>Obsidian quick_switch<CR>", "Find Note")
map_normal("<leader>os", "<cmd>Obsidian search<CR>", "Search Notes")
map_normal("<leader>ot", "<cmd>ObsidianTagsAll<CR>", "Find Notes With All Tags")
map_normal("<leader>ow", "<cmd>Obsidian workspace<CR>", "Switch Workspace")
map_normal("<leader>oi", "<cmd>Obsidian template<CR>", "Insert Template")
map_normal("<leader>ob", "<cmd>Obsidian backlinks<CR>", "Show Backlinks")
map_normal("<leader>oT", "<cmd>Obsidian toc<CR>", "Table of Contents")
map_normal("<leader>ol", function()
  require("util.obsidian_links_preview").pick_links_with_preview()
end, "List Links")
map_normal("<leader>op", "<cmd>Obsidian paste_img<CR>", "Paste Image")
map_normal("<leader>or", "<cmd>Obsidian rename<CR>", "Rename Note")

map_visual("<leader>ox", ":Obsidian extract_note<CR>", "Extract to New Note")
map_visual("<leader>ol", ":Obsidian link<CR>", "Link Selection")
map_visual("<leader>oL", ":Obsidian link_new<CR>", "Link New from Selection")
