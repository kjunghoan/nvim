return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local harpoon = require("harpoon")
    
    -- Set up harpoon with a basic configuration
    harpoon:setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
        key = function()
          return vim.loop.cwd()
        end
      }
    })

    -- Create a which-key prefix group for Harpoon
    local wk = require("which-key")
    wk.register({
      ["<leader>h"] = { name = "Harpoon", _ = "which_key_ignore" },
    })

    -- Function to handle telescope harpoon list
    local function toggle_telescope(harpoon_files)
      local conf = require("telescope.config").values
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
          local actions = require("telescope.actions")
          local action_state = require("telescope.actions.state")

          -- Delete harpoon mark
          map("n", "d", function()
            local selection = action_state.get_selected_entry()
            local list = harpoon:list()
            
            -- Find the item with matching path and remove it
            for idx, item in ipairs(list.items) do
              if item.value == selection.value then
                list:remove_at(idx)
                break
              end
            end
            
            actions.close(prompt_bufnr)
            -- Reopen telescope with updated list
            toggle_telescope(list)
          end)

          return true
        end
      }):find()
    end

    -- Register the keymaps
    wk.register({
      ["<leader>ha"] = {
        function()
          harpoon:list():add()
        end,
        "Harpoon Add File"
      },
      ["<leader>he"] = {
        function()
          local conf = require("telescope.config").values
          toggle_telescope(harpoon:list())
        end,
        "Harpoon Quick Menu"
      },
      ["<leader>h1"] = {
        function()
          harpoon:list():select(1)
        end,
        "Harpoon File 1"
      },
      ["<leader>h2"] = {
        function()
          harpoon:list():select(2)
        end,
        "Harpoon File 2"
      },
      ["<leader>h3"] = {
        function()
          harpoon:list():select(3)
        end,
        "Harpoon File 3"
      },
      ["<leader>h4"] = {
        function()
          harpoon:list():select(4)
        end,
        "Harpoon File 4"
      }
    })

    -- Additional navigation keymaps
    vim.keymap.set("n", "<C-S-P>", function()
      harpoon:list():prev()
    end)
    vim.keymap.set("n", "<C-S-N>", function()
      harpoon:list():next()
    end)
  end,
}
