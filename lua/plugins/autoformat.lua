return { -- Autoformat
  'stevearc/conform.nvim',
  cmd = { 'ConformInfo' },
  -- Formatting is manual, so conform loads on demand rather than on every
  -- write. Re-add `event = { 'BufWritePre' }` alongside `format_on_save`
  -- if you ever want it to run automatically.
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = { 'n', 'v' },
      desc = 'Format buffer',
    },
  },
  opts = {
    notify_on_error = false,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can run multiple formatters sequentially
      python = { 'isort', 'black' },
    },
  },
}
