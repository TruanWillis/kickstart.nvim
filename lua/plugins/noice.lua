return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  -- nvim-notify is deliberately absent: noice falls back to snacks.notifier,
  -- which this config already enables.
  dependencies = { 'MunifTanjim/nui.nvim' },
  -- Single opts table: lazy calls require('noice').setup(opts) for us. Splitting
  -- this across `opts` and a `config` function meant `opts` was silently dropped.
  opts = {
    lsp = {
      -- blink.cmp provides signature help (see 'lua/plugins/autocomplete.lua');
      -- leaving noice's enabled too gave two popups for the same thing.
      signature = { enabled = false },
    },
    presets = {
      bottom_search = true, -- classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages go to a split
      inc_rename = false, -- input dialog for inc-rename.nvim
      lsp_doc_border = true, -- border on hover docs and signature help
    },
  },
}
