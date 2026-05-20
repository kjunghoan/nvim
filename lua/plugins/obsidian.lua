-- https://github.com/obsidian-nvim/obsidian.nvim
return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = function()
    local default_workspaces = {}

    local local_config = package.loaded["local-config"]
    local workspaces = default_workspaces
    if local_config and local_config.obsidian_workspaces then
      workspaces = local_config.obsidian_workspaces
    end

    return {
      legacy_commands = false,
      workspaces = workspaces,
      frontmatter = {
        enabled = true,
      },

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

      completion = {
        blink = true,
        min_chars = 2,
      },

      picker = {
        name = "snacks.picker",
      },

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
    if opts.workspaces and #opts.workspaces > 0 then
      require("obsidian").setup(opts)
    else
      vim.notify(
        "No Obsidian workspaces configured. Create local-config.lua to add workspaces.",
        vim.log.levels.WARN
      )
      return
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        vim.opt_local.spell = true
        vim.opt_local.conceallevel = 1
      end,
    })

    local map = function(keys, cmd, desc)
      vim.keymap.set("n", keys, cmd, { noremap = true, silent = true, desc = desc })
    end
    local vmap = function(keys, cmd, desc)
      vim.keymap.set("v", keys, cmd, { noremap = true, silent = true, desc = desc })
    end

    map("<leader>oD", "<cmd>Obsidian dailies<CR>", "List daily Notes")
    map("<leader>oh", "<cmd>Obsidian help<CR>", "Help")
    map("<leader>on", "<cmd>Obsidian new<CR>", "New Note")
    map("<leader>oo", "<cmd>Obsidian open<CR>", "Open in Obsidian")
    map("<leader>od", "<cmd>Obsidian today<CR>", "Open Today Note")
    map("<leader>o[", "<cmd>Obsidian yesterday<CR>", "Open Yesterday Note")
    map("<leader>o]", "<cmd>Obsidian tomorrow<CR>", "Insert Template")
    map("<leader>of", "<cmd>Obsidian quick_switch<CR>", "Find Note")
    map("<leader>os", "<cmd>Obsidian search<CR>", "Search Notes")
    map("<leader>ot", "<cmd>Obsidian tags<CR>", "Search Tags")
    map("<leader>ow", "<cmd>Obsidian workspace<CR>", "Switch Workspace")

    map("<leader>ob", "<cmd>Obsidian backlinks<CR>", "Show Backlinks")
    map("<leader>oT", "<cmd>Obsidian toc<CR>", "Table of Contents")
    map("<leader>ol", ":Obsidian links<CR>", "List Links")
    map("<leader>op", "<cmd>Obsidian paste_img<CR>", "Paste Image")
    map("<leader>or", "<cmd>Obsidian rename<CR>", "Rename Note")

    vmap("<leader>ox", ":Obsidian extract_note<CR>", "Extract to New Note")
    vmap("<leader>ol", ":Obsidian link<CR>", "Link Selection")
    vmap("<leader>oL", ":Obsidian link_new<CR>", "Link New from Selection")
  end,
}
