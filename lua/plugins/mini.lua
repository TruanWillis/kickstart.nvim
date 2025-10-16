return {
  'echasnovski/mini.nvim',
  version = '*', -- optional, locks to stable API
  event = { 'VeryLazy' }, -- defer loading until after UI startup
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote

    require('mini.ai').setup { n_lines = 500 }
    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup {
      mappings = {
        add = 'ysa', -- Add surrounding in Normal and Visual modes
        delete = 'ysd', -- Delete surrounding
        find = 'ysf', -- Find surrounding (to the right)
        find_left = 'ysF', -- Find surrounding (to the left)
        highlight = 'ysh', -- Highlight surrounding
        replace = 'ysr', -- Replace surrounding
        update_n_lines = 'ysn', -- Update `n_lines`
        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },
    }
    require('mini.move').setup()
    require('mini.pairs').setup()

    -- Register with which-key
    local wk = require('which-key')
    wk.add({
      { "ys", group = "Mini surround" },
      { "ysa", desc = "Add surrounding", mode = { "n", "v" } },
      { "ysd", desc = "Delete surrounding" },
      { "ysf", desc = "Find surrounding (right)" },
      { "ysF", desc = "Find surrounding (left)" },
      { "ysh", desc = "Highlight surrounding" },
      { "ysr", desc = "Replace surrounding" },
      { "ysn", desc = "Update n_lines" },
    })
    -- don't init mini.files here (we’ll load it with keys below)
  end,

  -- keys = {
  --   {
  --     '<leader>e',
  --     function() require('mini.files').open() end,
  --     desc = 'File Explorer [Mini]',
  --   },
  -- },
}

