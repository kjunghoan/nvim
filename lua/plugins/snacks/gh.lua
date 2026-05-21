-- https://github.com/folke/snacks.nvim/blob/main/docs/gh.md
return {
  opts = {
    gh = { enabled = true },
  },
  keys = {
    { "<leader>gh", "<cmd>Snacks gh<CR>", desc = "Github" },
    { "<leader>ghi", function() Snacks.picker.gh_issue() end, desc = "open issues" },
    { "<leader>ghI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "all issues" },
    { "<leader>ghp", function() Snacks.picker.gh_pr() end, desc = "open PRs" },
    { "<leader>ghP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "all PRs" },

    { "<leader>ghc", "<cmd>Snacks gh  create<CR>", desc = "create" },
    {
      "<leader>ghci",
      function()
        vim.cmd("tabnew | terminal gh issue create")
        vim.cmd.startinsert()
      end,
      desc = "create issue",
    },
    {
      "<leader>ghcp",
      function()
        vim.cmd("tabnew | terminal gh pr create")
        vim.cmd.startinsert()
      end,
      desc = "create PR",
    },
  },
}
