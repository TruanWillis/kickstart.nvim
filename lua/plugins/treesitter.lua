return { -- Highlight, edit, and navigate code
  'nvim-treesitter/nvim-treesitter',
  event = "BufReadPre",
  build = ':TSUpdate',
  cmd = "TSUpdate",
  main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects', -- Add textobjects plugin
  },
  -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  opts = {
    ensure_installed = { 'python', 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
    -- Incremental selection
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
    -- Configure treesitter textobjects
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          -- Functions
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          -- Classes
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          -- Parameters/arguments
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          -- Conditionals
          ["ai"] = "@conditional.outer",
          ["ii"] = "@conditional.inner",
          -- Loops
          ['al'] = '@loop.outer',
          ['il'] = '@loop.inner',
          -- Blocks
          ["ab"] = "@block.outer",
          ["ib"] = "@block.inner",
        },
        -- Optionally, you can define your own textobjects like this
        -- ['iF'] = {
        --   python = '(function_definition) @function',
        --   cpp = '(function_definition) @function',
        --   c = '(function_definition) @function',
        --   java = '(method_declaration) @function',
        -- },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']f'] = '@function.outer',
          [']c'] = '@class.outer',
          [']l'] = '@loop.outer',
          ["]a"] = "@parameter.inner",
          ["]i"] = "@conditional.inner",
          [']s'] = { query = '@local.scope', query_group = 'locals', desc = 'Next scope' },
        },
        goto_next_end = {
          [']F'] = '@function.outer',
          [']C'] = '@class.outer',
          [']L'] = '@loop.outer',
        },
        goto_previous_start = {
          ['[f'] = '@function.outer',
          ['[c'] = '@class.outer',
          ['[l'] = '@loop.outer',
          ["[a"] = "@parameter.outer",
          ["[i"] = "@conditional.outer",
          ['[s'] = { query = '@local.scope', query_group = 'locals', desc = 'Previous scope' },
        },
        goto_previous_end = {
          ['[F'] = '@function.outer',
          ['[C'] = '@class.outer',
          ['[L'] = '@loop.outer',
        },
      },
      -- Swap adjacent objects
      swap = {
        enable = true,
        swap_next = {
          ["<leader>na"] = "@parameter.inner",  -- swap with next parameter
          ["<leader>nf"] = "@function.outer",   -- swap with next function
        },
        swap_previous = {
          ["<leader>pa"] = "@parameter.inner",  -- swap with previous parameter
          ["<leader>pf"] = "@function.outer",   -- swap with previous function
        },
      },
    },
  },
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}

