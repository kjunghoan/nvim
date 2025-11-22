-- https://github.com/obsidian-nvim/obsidian.nvim
return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = function()
    local default_workspaces = {}

    -- Check if local-config was loaded (by init.lua)
    local local_config = package.loaded["local-config"]
    local workspaces = default_workspaces
    if local_config and local_config.obsidian_workspaces then
      workspaces = local_config.obsidian_workspaces
    end

    return {
      legacy_commands = false,
      workspaces = workspaces,

    -- UI options
    ui = {
      enable = false,
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

    open = {
      func = vim.ui.open,
      app_foreground = false,
    },
    }
  end,

  config = function(_, opts)
    -- Only setup if we have workspaces configured
    if opts.workspaces and #opts.workspaces > 0 then
      require("obsidian").setup(opts)
    else
      vim.notify("No Obsidian workspaces configured. Create local-config.lua to add workspaces.", vim.log.levels.WARN)
      return
    end

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

    local vmap = function(keys, cmd, desc)
      vim.keymap.set("v", keys, cmd, { noremap = true, silent = true, desc = desc })
    end

    map("<leader>on", "<cmd>ObsidianNew<cr>", "New Note")
    map("<leader>of", "<cmd>ObsidianQuickSwitch<cr>", "Find Note")
    map("<leader>os", "<cmd>ObsidianSearch<cr>", "Search Notes")
    map("<leader>oo", "<cmd>ObsidianOpen<cr>", "Open in Obsidian")
    map("<leader>ob", "<cmd>ObsidianBacklinks<cr>", "Show Backlinks")
    map("<leader>ot", "<cmd>ObsidianTemplate<cr>", "Insert Template")
    map("<leader>od", "<cmd>ObsidianToday<cr>", "Open Today Note")
    map("<leader>oy", "<cmd>ObsidianYesterday<cr>", "Open Yesterday Note")
    map("<leader>ow", "<cmd>ObsidianWorkspace<cr>", "Switch Workspace")
    map("<leader>op", "<cmd>ObsidianPasteImg<cr>", "Paste Image")

    vmap("<leader>ol", ":ObsidianLink<cr>", "Link Selection")
    vmap("<leader>oL", ":ObsidianLinkNew<cr>", "Link New from Selection")
    vmap("<leader>ox", ":ObsidianExtractNote<cr>", "Extract to New Note")
  end,
}
