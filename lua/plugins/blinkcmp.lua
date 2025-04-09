-- https://github.com/Saghen/blink.cmp
return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = { 'rafamadriz/friendly-snippets' },

  -- use a release tag to download pre-built binaries
  version = '1.*',
  opts = {
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'default',
      ['<C-k>'] = {'select_prev', 'fallback'},
      ['<C-j>'] = { 'select_next', 'fallback'},
      ['<M-CR>'] = { 'accept', 'fallback'},
      ['<C-e>'] = {'hide', 'fallback'},
      ['<C-K>'] = { 'show_signature', 'hide_signature', 'fallback' },
      -- ['<M-space>'] = {'show', 'show_documenation', 'hide_documenation'},
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'normal'
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = { documentation = { auto_show = false } },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}
