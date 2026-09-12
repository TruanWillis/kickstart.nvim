# Neovim config

A personal Neovim setup, originally forked from
[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and since
restructured into per-plugin modules. Targets **Neovim 0.11+** and leans on
0.11's built-in LSP, snippet and commenting support rather than plugins.

## Running it

This config lives at `~/.config/kickstart`, so it needs `NVIM_APPNAME`:

```bash
nvim-kick          # alias for NVIM_APPNAME=kickstart nvim
nvims              # fzf picker over all configs (bound to Ctrl-A)
```

Plain `nvim` loads `~/.config/nvim`, which is a different (empty) config.

## Layout

```
init.lua                  leader key, lazy.nvim bootstrap, plugin list
lua/core/options.lua      vim options, provider toggles
lua/core/keymaps.lua      non-plugin keymaps
lua/core/autocmds.lua     autocommands
lua/plugins/*.lua         one file per plugin
after/lsp/<server>.lua    per-server LSP overrides (merged by Neovim)
```

Leader is **space**. Local leader is also space.

---

# Keybindings

## Leader groups

Press `<Space>` and wait — which-key shows the menu (helix preset, bottom-right).

| Prefix | Group |
|---|---|
| `<leader>f` | File |
| `<leader>b` | Buffer |
| `<leader>s` | Search |
| `<leader>g` | Git |
| `<leader>c` | Code |
| `<leader>u` | UI / Toggles |
| `<leader>n` | Swap with next |
| `<leader>p` | Swap with previous |

## Files and buffers

| Key | Action |
|---|---|
| `<leader><leader>` | Buffer switcher |
| `<leader>ff` | Find files |
| `<leader>fr` | Recent files |
| `<leader>fc` | Find a file in the config dir |
| `<leader>fe` | File explorer |
| `<leader>bb` | Buffer list |
| `<leader>bd` | Delete buffer |
| `<leader>bn` / `<leader>bp` | Next / previous buffer |
| `[b` / `]b` | Previous / next buffer |
| `<leader>/` | Fuzzy-search lines in the current buffer |

## Search and pickers

All backed by snacks.picker.

| Key | Action |
|---|---|
| `<leader>sp` | Grep the project |
| `<leader>sb` | Grep open buffers |
| `<leader>sw` | Grep the word under the cursor (also visual) |
| `<leader>sr` | Replace word under cursor, with confirmation |
| `<leader>so` / `<leader>sO` | Document / workspace symbols |
| `<leader>sd` / `<leader>sD` | All / buffer diagnostics |
| `<leader>sq` | Diagnostics to the location list |
| `<leader>sh` | Help pages |
| `<leader>sk` | Keymaps — **use this when you forget a binding** |
| `<leader>sn` | Notification history |
| `<leader>su` | Undo history |

Inside a picker, `<C-l>` sends all results to the location list.

## Git

| Key | Action |
|---|---|
| `<leader>gl` | Git log |
| `<leader>gL` | Git log for the current line |
| `<leader>gf` | Git log for the current file |
| `<leader>gd` | Git diff |

Change signs in the gutter come from gitsigns (`+` add, `~` change, `_`
delete). Hunk staging is not currently mapped.

## Code

| Key | Action |
|---|---|
| `<leader>cf` | Format buffer (conform: stylua / isort+black) |
| `<leader>cr` | Rename symbol |

Formatting is **manual** — saving does not reformat.

## UI toggles

| Key | Toggles |
|---|---|
| `<leader>us` | Spelling |
| `<leader>uw` | Wrap |
| `<leader>ul` / `<leader>uL` | Line numbers / relative numbers |
| `<leader>ud` | Diagnostics |
| `<leader>uc` | Conceal level |
| `<leader>uT` | Treesitter highlight |
| `<leader>ub` | Dark background |
| `<leader>uh` | Inlay hints |
| `<leader>ug` | Indent guides |
| `<leader>uD` | Dimming |
| `<leader>uz` | Zen mode |
| `<leader>.` | Scratch buffer |

## Quickfix and location list

| Key | Action |
|---|---|
| `<leader>q` | Toggle quickfix |
| `<leader>l` | Toggle location list |
| `>` / `<` | In a quickfix window: expand / collapse surrounding context |

## Motion — flash.nvim

| Key | Action |
|---|---|
| `s` | Jump to any visible location by label |
| `S` | Jump to a treesitter node |
| `r` | Remote flash (operator-pending, e.g. `yr` then a label) |
| `R` | Treesitter search (operator / visual) |
| `<C-s>` | Toggle flash while in search (`/`) |

Because flash owns `s`, mini.surround is remapped onto `ys` (below).

## Surround — mini.surround

| Key | Action |
|---|---|
| `ysa` | Add surrounding (also visual) |
| `ysd` | Delete surrounding |
| `ysr` | Replace surrounding |
| `ysf` / `ysF` | Find surrounding right / left |
| `ysh` | Highlight surrounding |

Add `n` or `l` for the next/previous match — `ysdn` deletes the next
surrounding.

Example: `ysa` + `iw` + `)` wraps the word in parentheses. `ysr` + `)` + `'`
turns parens into quotes.

## Text objects

Usable after any operator (`d`, `c`, `y`, `v`).

| Object | Selects |
|---|---|
| `af` / `if` | Function outer / inner |
| `ac` / `ic` | Class outer / inner |
| `aa` / `ia` | Parameter / argument |
| `ab` / `ib` | Block |
| `al` / `il` | Loop |
| `ai` / `ii` | Conditional |

### mini.ai next / last variants

These take a second character naming the delimiter, and act on a *nearby*
object without moving the cursor first:

| Key | Acts on |
|---|---|
| `an` / `in` | The **next** one, e.g. `dan)` deletes the next parens |
| `aL` / `iL` | The **previous** one, e.g. `daL)` deletes the previous parens |

mini.ai also adds `aq`/`iq` (any quote) and `a?`/`i?` (prompt for arbitrary
delimiters), and `g[` / `g]` jump to the edges of a text object.

> `aL`/`iL` are non-standard. mini.ai's defaults are `al`/`il`, but
> treesitter-textobjects claims those for loops and wins in any buffer with a
> parser — so they were remapped in `lua/plugins/mini.lua` to work
> consistently.

So `daf` deletes a function, `cif` changes a function body, `via` selects an
argument, `daL)` deletes the parenthesised group before the cursor.

## Navigation between things

| Key | Moves to |
|---|---|
| `]f` / `[f` | Next / previous function start |
| `]F` / `[F` | Next / previous function end |
| `]c` / `[c` | Next / previous class start |
| `]C` / `[C` | Next / previous class end |
| `]l` / `[l` | Next / previous loop start |
| `]L` / `[L` | Next / previous loop end |
| `]a` / `[a` | Next / previous parameter |
| `]i` / `[i` | Next / previous conditional |
| `]s` / `[s` | Next / previous scope |
| `]]` / `[[` | Next / previous reference to the symbol under the cursor |
| `]b` / `[b` | Next / previous buffer |
| `]q` / `[q` | Next / previous quickfix entry (Neovim built-in) |

**These override three Vim built-ins.** treesitter claims `]l`/`[l`,
`]a`/`[a` and `]s`/`[s`, which natively navigate the location list, the
arglist, and misspelled words. Use `:lnext` / `:lprev` and `:next` /
`:prev` instead. Losing `]s` matters most: with spell check on, that was
the way to jump between misspellings — `<leader>us` off and on won't bring
it back, since the mapping is unconditional.

## Swapping

| Key | Action |
|---|---|
| `<leader>na` / `<leader>pa` | Swap parameter with next / previous |
| `<leader>nf` / `<leader>pf` | Swap function with next / previous |

## Windows and tmux

`<C-h>` `<C-j>` `<C-k>` `<C-l>` move between splits **and** tmux panes
seamlessly. `<C-\>` jumps to the previous one.

## Completion — blink.cmp

| Key | Action |
|---|---|
| `<C-y>` | Accept the completion |
| `<C-n>` / `<C-p>` | Next / previous item |
| `<C-space>` | Open the menu, or show docs if already open |
| `<C-e>` | Dismiss |
| `<C-k>` | Toggle signature help |
| `<Tab>` / `<S-Tab>` | Move between snippet placeholders |

## Multi-cursor — vim-visual-multi

`<C-n>` selects the word under the cursor; press again to add the next
occurrence, then edit them all at once. `<Esc>` leaves multi-cursor mode.

| Key | Action |
|---|---|
| `<C-n>` | Select word under cursor / add next occurrence |
| `\\A` | Select all occurrences |
| `\\/` | Start a regex search for cursors |

The plugin's own leader is `\\` (backslash twice). See `:help visual-multi`
for the full set — it has a large default mapping table.

## Other

| Key | Action |
|---|---|
| `<Esc>` | Clear search highlight |
| `<Esc><Esc>` | Leave terminal mode |
| `<` / `>` in visual | Indent, keeping the selection |
| Arrow keys | Deliberately disabled in normal mode — use `hjkl` |

---

# Neovim's built-ins

Much of what distributions add as plugins is now in Neovim itself. This config
deliberately uses the built-ins, so these are worth knowing.

## LSP (0.11 defaults — no plugin, no config)

| Key | Action |
|---|---|
| `K` | Hover documentation |
| `grn` | Rename |
| `gra` | Code action |
| `grr` | References |
| `gri` | Implementation |
| `grt` | Type definition |
| `gO` | Document symbols |
| `<C-s>` | Signature help (**insert mode**) |
| `<C-]>` | Go to definition — the native tag jump, routed through LSP because Neovim sets `tagfunc`. `<C-t>` jumps back |
| `[d` / `]d` | Previous / next diagnostic |
| `[D` / `]D` | First / last diagnostic in the buffer |

These are why this config has no `LspAttach` keymap block.

## Commenting (0.10+)

| Key | Action |
|---|---|
| `gcc` | Toggle the current line |
| `gc` + motion | Toggle a range, e.g. `gcap` for a paragraph |
| `gc` in visual | Toggle the selection |

No commenting plugin is installed.

## Snippets (0.11)

LSP-provided snippets expand through `vim.snippet` — no snippet engine
plugin. `<Tab>` / `<S-Tab>` move between placeholders.

## Built-in bracket motions

| Key | Moves to |
|---|---|
| `[q` / `]q` | Previous / next quickfix entry |
| `[Q` / `]Q` | First / last quickfix entry |
| `[<C-q>` / `]<C-q>` | Quickfix entry in the previous / next file |

Note that `[l`/`]l` (location list), `[a`/`]a` (arglist) and `[s`/`]s`
(misspelled words) are **taken over by treesitter** in this config — see
*Navigation between things* above.

## Built-in text objects worth remembering

| Object | Selects |
|---|---|
| `iw` / `aw` | Word / word with surrounding space |
| `is` / `as` | Sentence |
| `ip` / `ap` | Paragraph |
| `i(` `i[` `i{` `i<` | Inside the bracket pair (`a` for including it) |
| `i"` `i'` `` i` `` | Inside quotes |
| `it` / `at` | Inside / around an HTML-ish tag |

## Other built-ins in use

- `gx` — open the URL or filepath under the cursor in the system handler
- `winborder` — one option gives every floating window a rounded border, so
  individual plugins don't set borders
- `:Tutor` — the built-in interactive tutorial
- `:checkhealth` — diagnose config and plugin problems
- `:Inspect` — show the highlight groups and treesitter captures under the
  cursor, useful for theming
- `:InspectTree` — live treesitter syntax tree

---

# Plugins

| Plugin | Role |
|---|---|
| lazy.nvim | Plugin manager |
| snacks.nvim | Pickers, explorer, toggles, notifier, scratch, zen, indent guides |
| blink.cmp | Completion |
| nvim-lspconfig | Server definitions for `vim.lsp.enable` |
| mason.nvim + mason-tool-installer | Installs servers and formatters |
| conform.nvim | Formatting |
| nvim-treesitter (+ textobjects) | Syntax, text objects, movement, swapping |
| mini.nvim | `ai` text objects, `surround`, `move`, `pairs` |
| which-key.nvim | Keybinding hints |
| flash.nvim | Jump motions |
| vim-illuminate | Highlights other uses of the symbol under the cursor |
| gitsigns.nvim | Git gutter signs |
| todo-comments.nvim | Highlights TODO / FIXME |
| quicker.nvim | Better quickfix window |
| noice.nvim | Cmdline and message UI |
| lualine.nvim | Statusline |
| catppuccin | Colourscheme |
| render-markdown.nvim | In-buffer markdown rendering |
| vim-visual-multi | Multiple cursors |
| vim-tmux-navigator | Split/pane navigation across tmux |
| lazydev.nvim | Lua LSP types for editing this config |
| vim-sleuth | Detects indentation |

---

# Things to know

**LSP only starts for Lua and Python.** `nvim-lspconfig` is `ft`-limited in
`lua/plugins/lsp.lua`. Opening a Go or JavaScript file gives you treesitter
highlighting but no LSP. To add a language, add the server to
`mason-tool-installer`'s `ensure_installed` (mason package name) and to
`vim.lsp.enable` (lspconfig name) — they differ for some servers, e.g.
`lua-language-server` vs `lua_ls`.

**Per-server settings go in `after/lsp/<name>.lua`**, not in `lsp.lua`.
Neovim merges them over nvim-lspconfig's defaults. See `after/lsp/lua_ls.lua`.

**`al` / `il` mean loop.** treesitter-textobjects and mini.ai both claim
these and treesitter wins, so mini.ai's "last" variants were moved to
`aL` / `iL` in `lua/plugins/mini.lua`. Worth knowing if you follow mini.ai's
own documentation, which says `al`.

**Spell check is on for every buffer.** Treesitter limits it to comments and
strings, so identifiers aren't flagged. `<leader>us` toggles it.

**The cursor stays vertically centred** (`scrolloff = 999`), so the view
scrolls on nearly every vertical movement.

**Language providers are disabled** in `options.lua`. Probing for a Python
host cost ~2.2s on every Python buffer. If you ever install a remote plugin,
re-enable the relevant `vim.g.loaded_*_provider`.

---

# Maintenance

| Command | Does |
|---|---|
| `:Lazy` | Plugin status; `U` updates, `X` cleans |
| `:Lazy profile` | Startup cost per plugin |
| `:Mason` | Installed servers and tools |
| `:checkhealth` | Everything |
| `:ConformInfo` | Which formatters apply here |

`lazy-lock.json` pins plugin versions and is committed — `:Lazy restore`
returns to the locked set.
