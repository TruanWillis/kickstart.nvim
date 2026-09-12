-- Highlight TODO, NOTE, FIXME etc. in comments
return {
  'folke/todo-comments.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  -- Command stubs so :Todo* still work before any file is opened.
  cmd = { 'TodoQuickFix', 'TodoLocList', 'TodoTrouble', 'TodoTelescope' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { signs = false },
}
