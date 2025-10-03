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
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }
    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup {
      mappings = {
        add = 'msa', -- Add surrounding in Normal and Visual modes
        delete = 'msd', -- Delete surrounding
        find = 'msf', -- Find surrounding (to the right)
        find_left = 'msF', -- Find surrounding (to the left)
        highlight = 'msh', -- Highlight surrounding
        replace = 'msr', -- Replace surrounding
        update_n_lines = 'msn', -- Update `n_lines`
        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },
    }
    require('mini.move').setup()
    require('mini.pairs').setup()

    -- Register with which-key
    local wk = require('which-key')
    wk.add({
      { "ms", group = "Mini surround" },
      { "msa", desc = "Add surrounding", mode = { "n", "v" } },
      { "msd", desc = "Delete surrounding" },
      { "msf", desc = "Find surrounding (right)" },
      { "msF", desc = "Find surrounding (left)" },
      { "msh", desc = "Highlight surrounding" },
      { "msr", desc = "Replace surrounding" },
      { "msn", desc = "Update n_lines" },
    })
    -- don't init mini.files here (we’ll load it with keys below)
  end,

  keys = {
    {
      '<leader>e',
      function() require('mini.files').open() end,
      desc = 'File Explorer [Mini]',
    },
  },
}

