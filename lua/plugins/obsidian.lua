-- https://github.com/obsidian-nvim/obsidian.nvim
return {
  "obsidian-nvim/obsidian.nvim",
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
      conceallevel = 1, -- Set conceallevel for better readability
    },

    notes_subdir = "notes",
    new_notes_location = "current_dir",
    completion = {
      blink = true, -- Enable blink.cmp integration
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
        vim.opt_local.spell = true
        vim.opt_local.conceallevel = 1 -- Set conceallevel for markdown files
      end,
    })

    local wk = require("which-key")
    wk.add({
      { "<leader>o",  group = "Obsidian" },
      { "<leader>oL", "<cmd>ObsidianLinkNew<cr>",     desc = "Link New Note" },
      { "<leader>ob", "<cmd>ObsidianBacklinks<cr>",   desc = "Show Backlinks" },
      { "<leader>od", "<cmd>ObsidianToday<cr>",       desc = "Open Today Note" },
      { "<leader>of", "<cmd>ObsidianQuickSwitch<cr>", desc = "Find Note" },
      { "<leader>ol", "<cmd>ObsidianLink<cr>",        desc = "Link Note" },
      { "<leader>on", "<cmd>ObsidianNew<cr>",         desc = "New Note" },
      { "<leader>oo", "<cmd>ObsidianOpen<cr>",        desc = "Open in Obsidian" },
      { "<leader>op", "<cmd>ObsidianPasteImg<cr>",    desc = "Paste Image" },
      { "<leader>os", "<cmd>ObsidianSearch<cr>",      desc = "Search Notes" },
      { "<leader>ot", "<cmd>ObsidianTemplate<cr>",    desc = "Insert Template" },
      { "<leader>ow", "<cmd>ObsidianWorkspace<cr>",   desc = "Switch Workspace" },
      { "<leader>oy", "<cmd>ObsidianYesterday<cr>",   desc = "Open Yesterday Note" },
    })
  end,
}
