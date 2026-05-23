-- https://github.com/ThePrimeagen/harpoon
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

    vks("n", "m", function()
      harp:list():add()
      vim.notify("File Marked", vim.log.levels.INFO)
    end, ext_opts("Harpoon Add File"))

    -- extracted so delete-mark can re-open via direct call (replaces the old
    -- vim.cmd("normal! \<TAB>") keycode bug; `local pick` shadow goes away too)
    local function quick_menu()
      local list = harp:list()
      local items = {}
      for idx = 1, list:length() do
        local item = list:get(idx)
        if item then
          items[#items + 1] = {
            idx = idx,
            text = string.format("%d: %s", idx, item.value),
            file = item.value,
            value = item,
          }
        end
      end
      if #items == 0 then
        vim.notify("No harpoon marks", vim.log.levels.WARN)
        return
      end
      Snacks.picker({
        source = "harpoon",
        items = items,
        format = "text",
        preview = "file",
        confirm = function(picker, item)
          picker:close()
          if item and item.idx then
            vim.schedule(function()
              harp:list():select(item.idx)
            end)
          end
        end,
        actions = {
          delete_mark = function(picker, item)
            if not item then
              return
            end
            list:remove(item.value)
            picker:close()
            vim.notify("Removed mark " .. item.idx, vim.log.levels.INFO)
            vim.schedule(quick_menu)
          end,
        },
        win = {
          input = {
            keys = {
              ["<C-d>"] = { "delete_mark", mode = { "n", "i" } },
            },
          },
        },
      })
    end

    vks("n", "<TAB>", quick_menu, ext_opts("Harpoon Quick Menu"))
  end,
}
