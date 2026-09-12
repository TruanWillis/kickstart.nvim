-- LSP Plugins
return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    ft = { 'lua', 'python' }, -- no LSP is started for other filetypes
    dependencies = {
      -- Installs the servers and formatters, and puts them on PATH.
      { 'mason-org/mason.nvim', opts = {} },
      {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        -- Mason package names, not lspconfig names.
        opts = {
          ensure_installed = {
            'lua-language-server',
            'pyright',
            'stylua',
            'isort',
            'black',
          },
        },
      },
      -- Registers completion capabilities with every server.
      'saghen/blink.cmp',
    },
    config = function()
      -- Server definitions come from nvim-lspconfig's `lsp/` directory;
      -- per-server overrides go in 'after/lsp/<name>.lua'. See `:help lsp-config`.
      vim.lsp.enable { 'lua_ls', 'pyright' }

      vim.diagnostic.config {
        severity_sort = true,
        float = { source = 'if_many' }, -- border from vim.o.winborder
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
