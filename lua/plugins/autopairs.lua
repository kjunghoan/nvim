-- https://github.com/windwp/nvim-autopairs
return {
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")

    npairs.setup({
      check_ts = true, -- Enable treesitter integration
      ts_config = {
        lua = {
          'string' -- Don't add pairs in lua string treesitter nodes
        },
        javascript = {
          'template_string' -- Don't add pairs in javscript template_string
        },
      },
      disable_filetype = {
        "TelescopePrompt",
        "vim"
      },
      fast_wrap = {
        map = "<M-e>", -- Alt+e to insert closing pair after cursor
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        check_comma = true,
        highlight = "Search",
        highlight_grey = "Comment"
      },
    })
  end
}

