-- https://github.com/obsidian-nvim/obsidian.nvim
return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = false,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    legacy_commands = false,
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

    -- New API for handling obsidian:// URIs
    open = {
      func = function(uri)
        -- Cross-platform URI opening for obsidian:// links
        if vim.fn.has("mac") == 1 then
          vim.ui.open(uri, { cmd = { "open", "-a", "/Applications/Obsidian.app" } })
        elseif vim.fn.has("unix") == 1 then
          -- On Linux, try common Obsidian installation paths
          local obsidian_paths = {
            "/usr/bin/obsidian",
            "/opt/Obsidian/obsidian",
            "obsidian" -- fallback to PATH
          }
          local obsidian_cmd = nil
          for _, path in ipairs(obsidian_paths) do
            if vim.fn.executable(path) == 1 then
              obsidian_cmd = path
              break
            end
          end
          if obsidian_cmd then
            vim.fn.jobstart({ obsidian_cmd, uri })
          else
            -- Fallback to xdg-open if Obsidian not found
            vim.ui.open(uri, { cmd = { "xdg-open" } })
          end
        elseif vim.fn.has("win32") == 1 then
          vim.ui.open(uri, { cmd = { "start" } })
        end
      end,
      app_foreground = false,
    },

    -- Handle regular URLs (non-obsidian:// URIs)
    follow_url_func = function(url)
      if vim.fn.has("mac") == 1 then
        vim.fn.jobstart({ "open", url })
      elseif vim.fn.has("unix") == 1 then
        vim.fn.jobstart({ "xdg-open", url })
      elseif vim.fn.has("win32") == 1 then
        vim.fn.jobstart({ "start", url })
      end
    end,
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
      { "<leader>oL", "<cmd>Obsidian link new<cr>",     desc = "Link New Note" },
      { "<leader>ob", "<cmd>Obsidian backlinks<cr>",    desc = "Show Backlinks" },
      { "<leader>od", "<cmd>Obsidian today<cr>",        desc = "Open Today Note" },
      { "<leader>of", "<cmd>Obsidian quick switch<cr>", desc = "Find Note" },
      { "<leader>ol", "<cmd>Obsidian link<cr>",         desc = "Link Note" },
      { "<leader>on", "<cmd>Obsidian new<cr>",          desc = "New Note" },
      { "<leader>oo", "<cmd>Obsidian open<cr>",         desc = "Open in Obsidian" },
      { "<leader>op", "<cmd>Obsidian paste img<cr>",    desc = "Paste Image" },
      { "<leader>os", "<cmd>Obsidian search<cr>",       desc = "Search Notes" },
      { "<leader>ot", "<cmd>Obsidian template<cr>",     desc = "Insert Template" },
      { "<leader>ow", "<cmd>Obsidian workspace<cr>",    desc = "Switch Workspace" },
      { "<leader>oy", "<cmd>Obsidian yesterday<cr>",    desc = "Open Yesterday Note" },
    })
  end,
}
