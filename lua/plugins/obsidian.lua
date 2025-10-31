-- https://github.com/obsidian-nvim/obsidian.nvim
return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = false,
  opts = {
    legacy_commands = false, -- Use new command format (Obsidian <subcommand>)
    workspaces = {
      {
        name = "primary",
        path = "~/notes",
      },
    },

    -- UI options
    ui = {
      enable = true,
      update_debounce = 200,
      bullets = {
        char = "•",
        padding = 1,
      },
      conceallevel = 1,
    },

    notes_subdir = "notes",
    new_notes_location = "current_dir",

    -- Completion integration with blink.cmp
    completion = {
      blink = true,
      min_chars = 2,
    },

    -- Picker integration with mini.pick
    picker = {
      name = "mini.pick",
    },

    -- Note ID generation
    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        for _ = 1, 4 do
          suffix = suffix .. tostring(math.random(0, 9))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
    end,

    disable_frontmatter = false,

    -- Templates
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },

    -- Use default vim.ui.open for opening URIs
    -- (won't work on headless, but graceful fallback)
    open = {
      func = vim.ui.open,
      app_foreground = false,
    },
  },

  config = function(_, opts)
    require("obsidian").setup(opts)

    -- Markdown file settings
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.opt_local.spell = true
        vim.opt_local.conceallevel = 1
      end,
    })

    -- Keymaps (using new command format)
    local map = function(keys, cmd, desc)
      vim.keymap.set("n", keys, cmd, { noremap = true, silent = true, desc = desc })
    end

    map("<leader>on", "<cmd>Obsidian new<cr>", "New Note")
    map("<leader>of", "<cmd>Obsidian quick_switch<cr>", "Find Note")
    map("<leader>os", "<cmd>Obsidian search<cr>", "Search Notes")
    map("<leader>oo", "<cmd>Obsidian open<cr>", "Open in Obsidian")
    map("<leader>ob", "<cmd>Obsidian backlinks<cr>", "Show Backlinks")
    map("<leader>ol", "<cmd>Obsidian link<cr>", "Link Note")
    map("<leader>oL", "<cmd>Obsidian link new<cr>", "Link New Note")
    map("<leader>ot", "<cmd>Obsidian template<cr>", "Insert Template")
    map("<leader>od", "<cmd>Obsidian today<cr>", "Open Today Note")
    map("<leader>oy", "<cmd>Obsidian yesterday<cr>", "Open Yesterday Note")
    map("<leader>ow", "<cmd>Obsidian workspace<cr>", "Switch Workspace")
    map("<leader>op", "<cmd>Obsidian paste img<cr>", "Paste Image")
  end,
}
