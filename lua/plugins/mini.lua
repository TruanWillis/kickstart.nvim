return {
  'echasnovski/mini.nvim',
  version = '*', -- optional, locks to stable API
  event = { 'VeryLazy' }, -- defer loading until after UI startup
  config = function()
    -- Around/Inside textobjects, e.g. `va)`, `yinq`
    require('mini.ai').setup {
      n_lines = 500,
      -- 'al'/'il' are claimed by nvim-treesitter-textobjects (loop), which wins
      -- in any buffer with a parser. Move mini.ai's "last" variants somewhere
      -- free so they work consistently. "next" (an/in) is unaffected.
      mappings = { around_last = 'aL', inside_last = 'iL' },
    }

    -- Surround, remapped onto a `ys` prefix so that `s` stays free for
    -- flash.nvim (see 'lua/plugins/flash.lua').
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
  end,
}

