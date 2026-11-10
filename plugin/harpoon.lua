-- https://github.com/ThePrimeagen/harpoon
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
})

local harpoon = require("harpoon")

harpoon:setup({
  settings = {
    key = function()
      return vim.fn.getcwd()
    end,
  },
})

local slot_letters = {}
for byte = string.byte("A"), string.byte("Z") do
  slot_letters[#slot_letters + 1] = string.char(byte)
end

local function list_for_slot(letter)
  return harpoon:list("slot_" .. letter)
end

local function load_every_slot_list()
  for _, letter in ipairs(slot_letters) do
    list_for_slot(letter)
  end
end

local function file_in_slot(letter)
  return list_for_slot(letter):get(1)
end

local function mark_current_file_in_slot(letter)
  list_for_slot(letter):replace_at(1)
  harpoon:sync()
  vim.notify("Harpoon " .. letter .. " set", vim.log.levels.INFO)
end

local function clear_slot(letter)
  list_for_slot(letter):remove_at(1)
  harpoon:sync()
end

local function jump_to_slot(letter)
  if not file_in_slot(letter) then
    vim.notify("Harpoon " .. letter .. " not set", vim.log.levels.WARN)
    return
  end
  list_for_slot(letter):select(1)
end

local function open_slot_picker()
  local picker_items = {}
  for _, letter in ipairs(slot_letters) do
    local harpoon_item = file_in_slot(letter)
    if harpoon_item then
      picker_items[#picker_items + 1] = {
        letter = letter,
        text = letter .. ": " .. harpoon_item.value,
        file = harpoon_item.value,
      }
    end
  end
  if #picker_items == 0 then
    vim.notify("No harpoon marks", vim.log.levels.WARN)
    return
  end
  Snacks.picker({
    source = "harpoon",
    items = picker_items,
    format = "text",
    preview = "file",
    confirm = function(picker, picker_item)
      picker:close()
      if picker_item then
        vim.schedule(function()
          jump_to_slot(picker_item.letter)
        end)
      end
    end,
    actions = {
      delete_mark = function(picker, picker_item)
        if not picker_item then
          return
        end
        clear_slot(picker_item.letter)
        picker:close()
        vim.notify("Harpoon " .. picker_item.letter .. " removed", vim.log.levels.INFO)
        vim.schedule(open_slot_picker)
      end,
    },
    win = {
      input = {
        keys = {
          ["<C-d>"] = { "delete_mark", mode = { "n", "i" } },
        },
      },
    },
  })
end

for _, letter in ipairs(slot_letters) do
  vim.keymap.set("n", "m" .. letter, function()
    mark_current_file_in_slot(letter)
  end, { desc = "Harpoon set " .. letter })
  for _, jump_prefix in ipairs({ "'", "`" }) do
    vim.keymap.set("n", jump_prefix .. letter, function()
      jump_to_slot(letter)
    end, { desc = "Harpoon jump " .. letter })
  end
end

vim.keymap.set("n", "m<Space>", open_slot_picker, { desc = "Harpoon menu" })
local function lowercase_marks_in_listed_buffers()
  local quickfix_items = {}
  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buffer].buflisted then
      for _, mark in ipairs(vim.fn.getmarklist(buffer)) do
        local letter = mark.mark:sub(2)
        if letter:match("^%l$") then
          local line_number = mark.pos[2]
          local line_text = vim.api.nvim_buf_is_loaded(buffer)
              and vim.api.nvim_buf_get_lines(buffer, line_number - 1, line_number, false)[1]
            or ""
          quickfix_items[#quickfix_items + 1] = {
            bufnr = buffer,
            lnum = line_number,
            col = mark.pos[3],
            text = letter .. "  " .. vim.trim(line_text or ""),
          }
        end
      end
    end
  end
  return quickfix_items
end

vim.keymap.set("n", "<leader>m", function()
  local quickfix_items = lowercase_marks_in_listed_buffers()
  if #quickfix_items == 0 then
    vim.notify("No marks set", vim.log.levels.WARN)
    return
  end
  vim.fn.setqflist({}, " ", { title = "Marks", items = quickfix_items })
  vim.cmd("Trouble qflist open")
end, { desc = "All marks" })

load_every_slot_list()
vim.api.nvim_create_autocmd("DirChanged", { callback = load_every_slot_list })
