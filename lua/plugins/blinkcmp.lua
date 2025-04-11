-- https://github.com/Saghen/blink.cmp
return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  -- use a release tag to download pre-built binaries
  version = '1.*',
  opts = {
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = 'default',
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<M-CR>'] = { 'accept', 'fallback' },
      ['<C-e>'] = { 'hide', 'fallback' },
      ['<C-K>'] = { 'show_signature', 'hide_signature', 'fallback' },
      -- ['<M-space>'] = {'show', 'show_documenation', 'hide_documenation'},
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      nerd_font_variant = 'normal'
    },

    completion = {
      documentation = { auto_show = false },
      list = {
        selection = {
          -- preselect = true, -- preselect the first item
          auto_insert = false, -- automatically insert the selected item
        }
      }
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
