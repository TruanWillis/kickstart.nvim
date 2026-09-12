-- Per-server overrides for lua_ls. Neovim merges this over nvim-lspconfig's
-- own 'lsp/lua_ls.lua'; see `:help lsp-config`.
--
-- Note lazydev.nvim supplies the workspace library for Neovim config editing,
-- so there is no `workspace.library` here.
return {
  settings = {
    Lua = {
      completion = { callSnippet = 'Replace' },
    },
  },
}
