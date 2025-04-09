return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "primary",
        path = "~/notes",
      },
    },

    -- Set UI options
    ui = {
      enable = true, -- Enable Obsidian's additional UI features
      update_debounce = 200,
      -- Checkboxes as bullets
      bullets = {
        char = "•",
        padding = 1,
      },
      -- Set markdown concealment
      conceallevel = 1, -- Set conceallevel to 1 for better readability
    },

    notes_subdir = "notes",
    new_notes_location = "current_dir",
    completion = {
      min_chars = 2,
    },

    -- Optional, customize how names/IDs are generated for new notes
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

    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },

    follow_url_func = function(url)
      vim.fn.jobstart({ "open", url }) -- Mac OS
    end,

    use_advanced_uri = false,
    open_app_foreground = false,
  },
  config = function(_, opts)
    require("obsidian").setup(opts)

    -- Set up autocommands for markdown files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
        vim.opt_local.conceallevel = 1 -- Set conceallevel for markdown files
      end,
    })

    local wk = require("which-key")
    wk.register({
      o = {
        name = "Obsidian",
        n = { "<cmd>ObsidianNew<cr>", "New Note" },
        o = { "<cmd>ObsidianOpen<cr>", "Open in Obsidian" },
        b = { "<cmd>ObsidianBacklinks<cr>", "Show Backlinks" },
        f = { "<cmd>ObsidianQuickSwitch<cr>", "Find Note" },
        s = { "<cmd>ObsidianSearch<cr>", "Search Notes" },
        t = { "<cmd>ObsidianTemplate<cr>", "Insert Template" },
        l = { "<cmd>ObsidianLink<cr>", "Link Note" },
        L = { "<cmd>ObsidianLinkNew<cr>", "Link New Note" },
        p = { "<cmd>ObsidianPasteImg<cr>", "Paste Image" },
        d = { "<cmd>ObsidianToday<cr>", "Open Today Note" },
        y = { "<cmd>ObsidianYesterday<cr>", "Open Yesterday Note" },
        w = { "<cmd>ObsidianWorkspace<cr>", "Switch Workspace" },
      },
    }, { prefix = "<leader>" })
  end,
}
