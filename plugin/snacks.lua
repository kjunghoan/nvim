vim.pack.add({ "https://github.com/folke/snacks.nvim" })

local lowercase_image_formats = {
  "png",
  "jpg",
  "jpeg",
  "gif",
  "bmp",
  "webp",
  "tiff",
  "heic",
  "avif",
  "mp4",
  "mov",
  "avi",
  "mkv",
  "webm",
  "pdf",
  "icns",
}

local image_formats_in_both_cases = {}
for _, format in ipairs(lowercase_image_formats) do
  table.insert(image_formats_in_both_cases, format)
  table.insert(image_formats_in_both_cases, format:upper())
end

require("snacks").setup({
  picker = {
    enabled = true,
    ui_select = true,
    matcher = { frecency = true },
    -- open files in the window focused when the picker launched,
    main = { current = true },
    win = {
      input = {
        keys = {
          ["<C-Up>"] = false,
          ["<C-Down>"] = false,
        },
      },
    },
    sources = {
      buffers = {
        win = {
          input = {
            keys = {
              ["<c-x>"] = false,
              ["<c-d>"] = { "bufdelete", mode = { "n", "i" } },
            },
          },
          list = {
            keys = {
              ["dd"] = false,
              ["<c-d>"] = "bufdelete",
            },
          },
        },
      },
    },
  },
  indent = {
    enabled = true,
    only_scope = true,
    only_current = true,
  },
  scope = { enabled = true, treesitter = { enabled = false } },
  lazygit = { enabled = true },
  gh = { enabled = true },
  image = {
    enabled = true,
    formats = image_formats_in_both_cases,
  },
})

-- image
require("util.image_buffer").register_autocmd()
require("util.pdf_pager").register_autocmd()

-- picker
vim.keymap.set("n", "<leader>ff", function()
  Snacks.picker.files()
end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>ft", function()
  Snacks.picker.grep()
end, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fr", function()
  Snacks.picker.recent()
end, { desc = "Recent Files" })
vim.keymap.set("n", "<leader>fF", function()
  Snacks.picker.files({ hidden = true, ignored = true })
end, { desc = "Find All Files" })
vim.keymap.set("n", "<leader>fb", function()
  Snacks.picker.buffers()
end, { desc = "Buffers" })

-- lazygit
vim.keymap.set("n", "<leader>gg", function()
  Snacks.lazygit()
end, { desc = "Lazygit" })

-- gh
vim.keymap.set("n", "<leader>gh", "<cmd>Snacks gh<CR>", { desc = "Github" })
vim.keymap.set("n", "<leader>ghi", function()
  Snacks.picker.gh_issue()
end, { desc = "open issues" })
vim.keymap.set("n", "<leader>ghI", function()
  Snacks.picker.gh_issue({ state = "all" })
end, { desc = "all issues" })
vim.keymap.set("n", "<leader>ghp", function()
  Snacks.picker.gh_pr()
end, { desc = "open PRs" })
vim.keymap.set("n", "<leader>ghP", function()
  Snacks.picker.gh_pr({ state = "all" })
end, { desc = "all PRs" })
vim.keymap.set("n", "<leader>ghc", "<cmd>Snacks gh create<CR>", { desc = "create" })
vim.keymap.set("n", "<leader>ghci", function()
  vim.cmd("tabnew | terminal gh issue create")
  vim.cmd.startinsert()
end, { desc = "create issue" })
vim.keymap.set("n", "<leader>ghcp", function()
  vim.cmd("tabnew | terminal gh pr create")
  vim.cmd.startinsert()
end, { desc = "create PR" })

vim.keymap.set("n", "<leader>i", function()
  local image = require("snacks.image")
  local buf = vim.api.nvim_get_current_buf()
  image.config.doc.inline = not image.config.doc.inline
  pcall(vim.api.nvim_del_augroup_by_name, "snacks.image.doc." .. buf)
  pcall(vim.api.nvim_del_augroup_by_name, "snacks.image.inline." .. buf)
  Snacks.image.placement.clean(buf)
  vim.b[buf].snacks_image_attached = nil
  Snacks.image.doc.attach(buf)
  Snacks.notify("Image: " .. (image.config.doc.inline and "inline" or "hover float"))
end, { desc = "Toggle image render: inline / hover float" })
