-- LSP Plugins
return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    ft = { 'lua', 'python' }, -- no LSP is started for other filetypes
    dependencies = {
      -- Mason must be loaded before its dependents.
      { 'mason-org/mason.nvim', event = 'VeryLazy', opts = {} },
      {
        'mason-org/mason-lspconfig.nvim',
        event = 'VeryLazy',
        opts = {
          ensure_installed = { 'lua_ls', 'pyright' },
          -- Allowlist, not a denylist: mason-lspconfig enables *every* installed
          -- package that nvim-lspconfig has an `lsp/` entry for, which silently
          -- turned stylua into a language server. Naming the servers explicitly
          -- keeps that from happening again as tools are added.
          automatic_enable = { 'lua_ls', 'pyright' },
        },
      },
      {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        event = 'VeryLazy',
        -- Formatters only; servers are mason-lspconfig's job.
        opts = { ensure_installed = { 'stylua', 'isort', 'black' } },
      },

      -- Registers completion capabilities with every server; see below.
      'saghen/blink.cmp',
    },
    config = function()
      -- Per-server settings live in 'after/lsp/<name>.lua' and are merged by
      -- Neovim itself. See `:help lsp-config`.
      --
      -- Capabilities are not wired up here on purpose: blink.cmp's own
      -- 'plugin/blink-cmp.lua' already calls `vim.lsp.config('*', ...)` on
      -- Neovim 0.11+, which applies to every server.
      --
      -- Keymaps are likewise built in as of 0.11 -- `grn` rename, `gra` code
      -- action, `grr` references, `gri` implementation, `grt` type definition,
      -- `gO` document symbol, `K` hover, `<C-S>` signature help. Pickers for
      -- symbols and diagnostics are in 'lua/plugins/snacks.lua'; reference
      -- highlighting is handled by 'lua/plugins/illuminate.lua'.

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = { source = 'if_many', spacing = 2 },
      }
    end,
  },
}
