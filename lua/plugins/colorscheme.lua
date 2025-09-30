return {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      require('catppuccin').setup()
      vim.cmd.colorscheme 'catppuccin'
    end,
  }
