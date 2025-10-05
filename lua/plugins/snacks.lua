return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    lazygit = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = false },
    indent = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = false },
    scope = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
    toggle = { enabled = true },
    scroll = {
      enable = true,
      filter = function(buf)
        return vim.g.snacks_scroll ~= false
        and vim.b[buf].snacks_scroll ~= false
        and vim.bo[buf].buftype ~= "terminal"
        and vim.bo[buf].filetype ~= "blink-cmp-menu"
      end,
    },
  },
  keys = {
    -- Files & Buffers
    { "<leader><leader>", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fe", function() Snacks.explorer() end, desc = "File Explorer [Snacks]" },
    { "<leader>ff",       function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fc",       function() Snacks.picker.files { cwd = vim.fn.stdpath("config") } end, desc = "Find Config File" },
    { "<leader>fr",       function() Snacks.picker.recent() end, desc = "Recent Files" },

    -- Git
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },

    -- Search
    { "<leader>/",  function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sp", function() Snacks.picker.grep() end, desc = "Grep Project" },
    { "<leader>sb", function() Snacks.picker.grep_buffers() end, desc = "Grep Buffers" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, mode = { "n", "x" }, desc = "Grep Word" },
    { "<leader>so", function() Snacks.picker.lsp_symbols() end, desc = "Buffer Symbols" },
    { "<leader>sO", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace Symbols" },

    -- Diagnostics & Misc
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>sn", function() Snacks.picker.notifications() end, desc = "Notification History" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
  },
}

