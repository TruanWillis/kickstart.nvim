-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

return {
  "folke/snacks.nvim",
  keys = {
    { "<leader>e",  false },
    { "<leader>E",  false },
    { "<leader>gc", false },
    { "<leader>gd", false },
    { "<leader>gs", false },
    { "<leader>dS", false },
    { "<leader>,",  false },
  }
}
