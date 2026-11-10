-- https://github.com/folke/trouble.nvim
vim.pack.add({ "https://github.com/folke/trouble.nvim" })

local flat_list_sorted_by_location = {
  groups = {},
  sort = { "filename", "pos" },
}

local function flat_list_with_format(format)
  return vim.tbl_extend("force", flat_list_sorted_by_location, { format = format })
end

require("trouble").setup({
  focus = true,
  auto_preview = false,
  indent_guides = false,
  multiline = false,
  win = { position = "bottom", size = 10 },
  modes = {
    diagnostics = flat_list_with_format(
      "{severity_icon} {filename} {pos} {message:md} {item.source} {code}"
    ),
    qflist = flat_list_with_format(
      "{severity_icon|item.type:DiagnosticSignWarn} {filename} {pos} {text:ts}"
    ),
    loclist = flat_list_with_format(
      "{severity_icon|item.type:DiagnosticSignWarn} {filename} {pos} {text:ts}"
    ),
    todo = flat_list_with_format("{todo_icon} {filename} {pos} {text}"),
  },
})

vim.keymap.set("n", "<leader>qQ", "<cmd>Trouble<cr>", { desc = "Trouble" })
vim.keymap.set(
  "n",
  "<leader>qq",
  "<cmd>Trouble diagnostics toggle<cr>",
  { desc = "Diagnostics (Trouble)" }
)
vim.keymap.set(
  "n",
  "<leader>qb",
  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  { desc = "Buffer diagnostics (Trouble)" }
)
vim.keymap.set(
  "n",
  "<leader>qf",
  "<cmd>Trouble qflist toggle<cr>",
  { desc = "Quickfix list (Trouble)" }
)
vim.keymap.set(
  "n",
  "<leader>ql",
  "<cmd>Trouble loclist toggle<cr>",
  { desc = "Location list (Trouble)" }
)
vim.keymap.set(
  "n",
  "<leader>qt",
  "<cmd>Trouble todo toggle<cr>",
  { desc = "Todos (Trouble)" }
)
