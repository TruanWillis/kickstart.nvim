return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    lazygit = { enabled = true },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    indent = { enabled = true },
    input = { enabled = false },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = true },
    statuscolumn = { enabled = false },
    words = { enabled = false },
  },
  -- keys = {
  -- {
  --   '<leader>gg',
  --   function()
  --     Snacks.lazygit { cwd = LazyVim.root.git() }
  --   end,
  --   { desc = 'Lazygit (Root Dir)' },
  -- },
  -- vim.keymap.set('n', '<leader>gg', function()
  --   require('snacks').lazygit()
  -- end, { desc = 'Lazygit (cwd)' }),
  -- {
  --   '<leader>gf',
  --   function()
  --     Snacks.picker.git_log_file()
  --   end,
  --   { desc = 'Git Current File History' },
  -- },
  -- {
  --   '<leader>gl',
  --   function()
  --     Snacks.picker.git_log { cwd = LazyVim.root.git() }
  --   end,
  --   { desc = 'Git Log' },
  -- },
  -- {
  --   '<leader>gL',
  --   function()
  --     Snacks.picker.git_log()
  --   end,
  --   { desc = 'Git Log (cwd)' },
  -- },
  -- {
  --   '<leader>gl',
  --   function()
  --     require('snacks').lazygit.log()
  --   end,
  --   { desc = 'Git Log (cwd)' },
  --   },
  -- },
  keys = {
    vim.keymap.set('n', '<leader>gg', function()
      require('snacks').lazygit()
    end, { desc = 'Lazygit' }),
    vim.keymap.set('n', '<leader>gl', function()
      require('snacks').lazygit.log_file()
    end, { desc = 'Git Log (file)' }),
    vim.keymap.set('n', '<leader>gL', function()
      require('snacks').lazygit.log()
    end, { desc = 'Git Log' }),
    vim.keymap.set('n', '<leader>n', function()
      require('snacks').notifier.show_history()
    end, { desc = '[N]otification History' }),
    -- find
    vim.keymap.set('n', '<leader>pb', function()
      Snacks.picker.buffers()
    end, { desc = 'Buffers' }),
    -- vim.keymap.set('n', '<leader>fc', function()
    --   Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
    -- end, { desc = 'Find Config File' }),
    vim.keymap.set('n', '<leader>pf', function()
      Snacks.picker.files()
    end, { desc = 'Find Files' }),
    vim.keymap.set('n', '<leader>pg', function()
      Snacks.picker.git_files()
    end, { desc = 'Find Git Files' }),
    vim.keymap.set('n', '<leader>pp', function()
      Snacks.picker.projects()
    end, { desc = 'Projects' }),
    vim.keymap.set('n', '<leader>pr', function()
      Snacks.picker.recent()
    end, { desc = 'Recent' }),
  },
}
