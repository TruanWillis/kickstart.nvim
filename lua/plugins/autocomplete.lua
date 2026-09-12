return { -- Autocompletion
  'saghen/blink.cmp',
  event = 'InsertEnter',
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    -- 'default' gives mappings similar to built-in completion: <c-y> accepts,
    -- <c-space> opens the menu/docs, <c-n>/<c-p> cycle, <c-e> hides,
    -- <c-k> toggles signature help.
    -- See `:help blink-cmp-config-keymap` to define your own.
    keymap = { preset = 'default' },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    completion = {
      -- Press <c-space> to show documentation.
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
      menu = {
        border = 'rounded',
        scrollbar = true,
        max_height = 6,
        draw = {
          -- Icon and label only.
          columns = { { 'kind_icon', 'label', gap = 1 } },
        },
      },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },

    -- Neovim's built-in `vim.snippet` (0.11+). Snippets sent by language
    -- servers still expand; no separate snippet engine is needed.
    snippets = { preset = 'default' },

    -- The optional Rust fuzzy matcher downloads a prebuilt binary; the Lua
    -- implementation avoids that. Set 'prefer_rust_with_warning' to opt in.
    -- See `:help blink-cmp-config-fuzzy`.
    fuzzy = { implementation = 'lua' },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
  },
}
