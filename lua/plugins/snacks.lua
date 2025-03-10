return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    lazygit = { enabled = true,
      keys = {
      {"<leader>gg", function() Snacks.lazygit( { cwd = LazyVim.root.git() }) end, { desc = "Lazygit (Root Dir)" }},
      {"<leader>gG", function() Snacks.lazygit() end, { desc = "Lazygit (cwd)" }},
      {"<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Current File History" }},
      {"<leader>gl", function() Snacks.picker.git_log({ cwd = LazyVim.root.git() }) end, { desc = "Git Log" }},
      {"<leader>gL", function() Snacks.picker.git_log() end, { desc = "Git Log (cwd)" }},
    },
    },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    indent = { enabled = false },
    input = { enabled = false },
    picker = { enabled = false },
    notifier = { enabled = false },
    quickfile = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = true },
    statuscolumn = { enabled = false },
    words = { enabled = false },
  },
}
