-- https://github.com/Saghen/blink.cmp
return {
  'saghen/blink.cmp',
  dependencies = { 'rafamadriz/friendly-snippets' },
  -- use a release tag to download pre-built binaries
  version = '1.*',
  config = function()
    local blink = require('blink.cmp')

    -- Set up LSP capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.preselectSupport = true
    capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
    capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
    capabilities.textDocument.completion.completionItem.deprecatedSupport = true
    capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
    capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
      }
    }

    -- Make these capabilities available for LSP configs
    vim.g.blink_cmp_capabilities = capabilities

    -- Configure blink.cmp
    blink.setup({
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = 'default',
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<M-CR>'] = { 'accept', 'fallback' },
        ['<C-e>'] = { 'hide', 'fallback' },
        ['<C-K>'] = { 'show_signature', 'hide_signature', 'fallback' },
      },

      appearance = {
        nerd_font_variant = 'normal'
      },

      completion = {
        documentation = { auto_show = true },
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          }
        }
      },
      sources = {
        default = {
          'lsp',
          'path',
          'snippets',
          'buffer'
        },
      },
      fuzzy = {
        implementation = "prefer_rust_with_warning"
      }
    })
  end,
}
