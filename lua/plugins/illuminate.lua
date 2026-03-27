return {
  "RRethy/vim-illuminate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    delay = 150,
    large_file_cutoff = 2000,
  },
  config = function(_, opts)
    -- This plugin is a "snowflake" and uses .configure instead of .setup
    require("illuminate").configure(opts)
    
    -- Optional: Add keymaps to jump between highlights
    vim.keymap.set("n", "]]", function() require("illuminate").goto_next_reference(false) end, { desc = "Next Reference" })
    vim.keymap.set("n", "[[", function() require("illuminate").goto_prev_reference(false) end, { desc = "Prev Reference" })
  end,
}
