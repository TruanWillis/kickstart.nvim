return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = 'markdown',
  -- mini.nvim supplies the icons (see 'lua/plugins/mini.lua')
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
}
