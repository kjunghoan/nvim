return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
      config = function ()
        local wk = require("which-key")
        wk.register {
          ["<leader>e"] = { "<cmd>NvimTreeToggle<cr>", "Toggle" },
          ["<leader>r"] = { "<cmd>NvimTreeRefresh<cr>", "Refresh" },
          ["<leader>n"] = { "<cmd>NvimTreeFindFile<cr>", "Find File" },
        }
      end,
    }
}