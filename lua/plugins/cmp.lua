vim.opt.completeopt = { "menu", "menuone", "noselect", "fuzzy" }
return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        native_menu = false,
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-p>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<M-CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        window = {
          completion = { border = vim.o.winborder or "rounded" },
          documentation = { border = vim.o.winborder or "rounded" },
        },
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      -- Command line completion setup
      cmp.setup.cmdline(":", {
        completion = { completeopt = "menu,menuone,noselect" },
        mapping = {
          ["<Tab>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_next_item()
            else
              cmp.complete()
            end
          end),
          ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item()
            end
          end),
          ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item()),
          ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item()),
          ["<C-e>"] = cmp.mapping(cmp.mapping.abort()),
          ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = true })),
        },
        sources = {
          { name = "cmdline" },
          { name = "path" },
        },
      })
    end,
  },
}
