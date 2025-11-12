-- https://github.com/obsidian-nvim/obsidian.nvim
return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = false,
  -- ft = { "markdown" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    legacy_commands = false,
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

    map("<leader>on", "<cmd>ObsidianNew<cr>", "New Note")
    map("<leader>of", "<cmd>ObsidianQuickSwitch<cr>", "Find Note")
    map("<leader>os", "<cmd>ObsidianSearch<cr>", "Search Notes")
    map("<leader>oo", "<cmd>ObsidianOpen<cr>", "Open in Obsidian")
    map("<leader>ob", "<cmd>ObsidianBacklinks<cr>", "Show Backlinks")
    map("<leader>ol", "<cmd>ObsidianLink<cr>", "Link Note")
    map("<leader>oL", "<cmd>ObsidianLinkNew<cr>", "Link New Note")
    map("<leader>ot", "<cmd>ObsidianTemplate<cr>", "Insert Template")
    map("<leader>od", "<cmd>ObsidianToday<cr>", "Open Today Note")
    map("<leader>oy", "<cmd>ObsidianYesterday<cr>", "Open Yesterday Note")
    map("<leader>ow", "<cmd>ObsidianWorkspace<cr>", "Switch Workspace")
    map("<leader>op", "<cmd>ObsidianPasteImg<cr>", "Paste Image")
  end,
}
