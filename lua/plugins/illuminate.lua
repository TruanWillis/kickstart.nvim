-- Highlights other occurrences of the symbol under the cursor.
return {
  'RRethy/vim-illuminate',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    delay = 150,
    large_file_cutoff = 2000,
  },
  config = function(_, opts)
    -- Note this plugin uses .configure(), not the usual .setup().
    require('illuminate').configure(opts)

    vim.keymap.set('n', ']]', function()
      require('illuminate').goto_next_reference(false)
    end, { desc = 'Next Reference' })
    vim.keymap.set('n', '[[', function()
      require('illuminate').goto_prev_reference(false)
    end, { desc = 'Prev Reference' })
  end,
}
