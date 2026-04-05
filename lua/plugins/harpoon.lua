return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harp = require("harpoon")
    local vks = vim.keymap.set
    harp.setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
        key = function()
          return vim.fn.getcwd()
        end,
      },
    })
    local opts = { noremap = true, silent = true }
    local function ext_opts(desc)
      return vim.tbl_extend("force", opts, { desc = desc })
    end

    -- Add file to harpoon
    vks("n", "m", function()
      harp:list():add()
      vim.notify("File Marked", vim.log.levels.INFO)
    end, ext_opts("Harpoon Add File"))

    -- Show harpoon marks in mini.pick
    vks("n", "<TAB>", function()
      local harpoon_files = harp:list()
      local items = {}

      for idx = 1, harpoon_files:length() do
        local item = harpoon_files:get(idx)
        if item then
          table.insert(items, string.format("%d: %s", idx, item.value))
        end
      end

      if #items == 0 then
        vim.notify("No harpoon marks", vim.log.levels.WARN)
        return
      end

      local pick = require("mini.pick")
      pick.start({
        source = {
          items = items,
          name = "Harpoon",
          choose = function(selected)
            if selected then
              local idx = tonumber(selected:match("^(%d+):"))
              if idx then
                local pick = require("mini.pick")
                pick.stop()
                vim.schedule(function()
                  harp:list():select(idx)
                end)
              end
            end
          end,
          preview = function(buf_id, item)
            if item then
              local path = item:match("^%d+: (.+)$")
              if path and vim.fn.filereadable(path) == 1 then
                local lines = vim.fn.readfile(path)
                vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
                -- Set filetype for syntax highlighting
                local ft = vim.filetype.match({ filename = path })
                if ft then
                  vim.bo[buf_id].filetype = ft
                end
              end
            end
          end,
        },
        mappings = {
          delete_mark = {
            char = "<C-d>",
            func = function()
              local matches = pick.get_picker_matches()
              if matches and matches.current then
                local selected = matches.current
                local idx = tonumber(selected:match("^(%d+):"))
                if idx then
                  harp:list():remove(harp:list():get(idx))
                  vim.notify("Removed mark " .. idx, vim.log.levels.INFO)
                  -- Close and reopen picker to refresh
                  vim.defer_fn(function()
                    pick.stop()
                    vim.cmd("normal! \\<TAB>")
                  end, 100)
                end
              end
            end,
          },
        },
      })
    end, ext_opts("Harpoon Quick Menu (mini.pick)"))

    -- Navigate through marks
    vks("n", "<C-S-P>", function()
      harp:list():prev()
    end, opts)
    vks("n", "<C-S-N>", function()
      harp:list():next()
    end, opts)

    vks("n", "<leader>1", function()
      harp:list():select(1)
    end, ext_opts("Harpoon 1"))
    vks("n", "<leader>2", function()
      harp:list():select(2)
    end, ext_opts("Harpoon 2"))
    vks("n", "<leader>3", function()
      harp:list():select(3)
    end, ext_opts("Harpoon 3"))
    vks("n", "<leader>4", function()
      harp:list():select(4)
    end, ext_opts("Harpoon 4"))
  end,
}
