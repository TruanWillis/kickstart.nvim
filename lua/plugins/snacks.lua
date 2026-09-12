return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    lazygit = { enabled = false },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    indent = { enabled = true },
    picker = {
      enabled = true,
      mappings = {
        ["<C-l>"] = function(picker)
          local items = picker:get_items()
          if not items or #items == 0 then
            return
          end

          local loclist = {}
          for _, item in ipairs(items) do
            if item.filename and item.lnum then
              table.insert(loclist, {
                filename = item.filename,
                lnum = item.lnum,
                col = item.col,
                text = item.text,
              })
            end
          end

          if #loclist > 0 then
            vim.fn.setloclist(0, {}, "r")
            vim.fn.setloclist(0, loclist, "a")
            vim.cmd("lopen")
            picker:close()
          end
        end,
      },
    },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = false },
    scratch = { enabled = true },
    statuscolumn = { enabled = false },
    words = { enabled = false },
    toggle = { enabled = true },
    zen = { enabled = true }, -- Enabled zen mode
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
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
  keys = {
    { "<leader><leader>", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>/", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    -- File
    { "<leader>fe", function() Snacks.explorer() end, desc = "File Explorer [Snacks]" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fc", function() Snacks.picker.files { cwd = vim.fn.stdpath("config") } end, desc = "Find Config File" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },

    -- Buffer
    { "<leader>bb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>bd", function() vim.cmd("bdelete") end, desc = "Delete Buffer" },
    { "<leader>bn", function() vim.cmd("bnext") end, desc = "Next Buffer" },
    { "<leader>bp", function() vim.cmd("bprevious") end, desc = "Previous Buffer" },

    -- Search
    { "<leader>sp", function() Snacks.picker.grep() end, desc = "Grep Project" },
    { "<leader>sb", function() Snacks.picker.grep_buffers() end, desc = "Grep Buffers" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, mode = { "n", "x" }, desc = "Grep Word" },
    { "<leader>so", function() Snacks.picker.lsp_symbols() end, desc = "Buffer Symbols" },
    { "<leader>sO", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace Symbols" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>sn", function() Snacks.picker.notifications() end, desc = "Notification History" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
    { "<leader>sq", vim.diagnostic.setloclist, desc = "Diagnostic quickfix list" },
    {
      "<leader>sr",
      function()
        local word = vim.fn.expand("<cword>")
        vim.api.nvim_feedkeys(
          ":" .. "%s/\\<" .. word .. "\\>//gc" .. vim.api.nvim_replace_termcodes("<Left><Left><Left>", true, false, true),
          "n",
          false
        )
      end,
      desc = "Replace word under cursor (confirm)",
    },

    -- Git
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },

    -- Code
    { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },

    -- UI/Toggles
    { "<leader>uz", function() Snacks.zen() end, desc = "Toggle Zen Mode" },
    { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
  },
}

