vim.pack.add({
  "https://github.com/nvim-mini/mini.statusline",
  "https://github.com/nvim-mini/mini.ai",
  "https://github.com/nvim-mini/mini.surround",
})

local mini_statusline = require("mini.statusline")

local sops_status_labels = {
  encrypted = { text = "SOPS encrypted", highlight = "MiniStatuslineDevinfo" },
  decrypted = { text = "SOPS DECRYPTED", highlight = "MiniStatuslineModeReplace" },
}

local function active_statusline_content()
  local mode, mode_highlight = mini_statusline.section_mode({ trunc_width = 120 })
  local git = mini_statusline.section_git({ trunc_width = 40 })
  local diff = mini_statusline.section_diff({ trunc_width = 75 })
  local diagnostics = mini_statusline.section_diagnostics({ trunc_width = 75 })
  local lsp = mini_statusline.section_lsp({ trunc_width = 75 })
  local filename = mini_statusline.section_filename({ trunc_width = 140 })
  local fileinfo = mini_statusline.section_fileinfo({ trunc_width = 120 })
  local location = mini_statusline.section_location({ trunc_width = 75 })
  local search = mini_statusline.section_searchcount({ trunc_width = 75 })
  local sops_status = sops_status_labels[vim.b.sops_status] or {}

  return mini_statusline.combine_groups({
    { hl = mode_highlight, strings = { mode } },
    { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
    "%<",
    { hl = "MiniStatuslineFilename", strings = { filename } },
    "%=",
    { hl = sops_status.highlight, strings = { sops_status.text } },
    { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
    { hl = mode_highlight, strings = { search, location } },
  })
end

mini_statusline.setup({ content = { active = active_statusline_content } })
require("mini.surround").setup()
require("mini.ai").setup()
