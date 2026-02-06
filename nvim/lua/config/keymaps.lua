-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- ================================
-- Quick Save & Quit (VS Code style)
-- ================================
-- Ctrl+S to save (works in normal and insert mode)
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Ctrl+Shift+S to save all
map({ "n", "i", "v" }, "<C-S-s>", "<cmd>wa<cr><esc>", { desc = "Save all files" })

-- Ctrl+Q to quit everything (close nvim completely)
map("n", "<C-q>", "<cmd>qa<cr>", { desc = "Quit all" })

-- Leader+Q to quit all (alternative)
map("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit all" })

-- Leader+W to save and quit current buffer properly
map("n", "<leader>W", "<cmd>w<cr><cmd>bd<cr>", { desc = "Save and close buffer" })

-- Close all windows and quit (when :q is annoying)
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all windows" })

-- ================================
-- Formatting (VS Code style)
-- ================================
-- Ctrl+Shift+F to format (like VS Code)
-- Note: In terminal, Ctrl+Shift+F might not work, so we also add Alt+Shift+F
map({ "n", "v" }, "<C-S-f>", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file" })

map({ "n", "v" }, "<A-S-f>", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file (Alt)" })

-- Leader+cf also formats (LazyVim default, keeping it)
map({ "n", "v" }, "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file" })

-- ================================
-- Buffer Navigation (easier)
-- ================================
-- Shift+H/L to switch buffers (LazyVim default, but explicit)
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Close buffer without closing window
map("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Delete buffer" })
map("n", "<leader>bD", "<cmd>bd!<cr>", { desc = "Delete buffer (force)" })

-- ================================
-- Neo-tree shortcuts
-- ================================
-- Quick toggle file explorer
map("n", "<C-b>", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })
map("n", "<C-e>", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })

-- ================================
-- Copilot Chat
-- ================================
-- Explicit toggle for Copilot Chat
map("n", "<leader>cc", "<cmd>CopilotChatToggle<cr>", { desc = "Toggle Copilot Chat" })
map("v", "<leader>cc", "<cmd>CopilotChatToggle<cr>", { desc = "Toggle Copilot Chat" })

-- Quick actions
map("n", "<leader>ce", "<cmd>CopilotChatExplain<cr>", { desc = "Explain code" })
map("v", "<leader>ce", "<cmd>CopilotChatExplain<cr>", { desc = "Explain selection" })
map("n", "<leader>cr", "<cmd>CopilotChatReview<cr>", { desc = "Review code" })
map("v", "<leader>cr", "<cmd>CopilotChatReview<cr>", { desc = "Review selection" })
map("n", "<leader>ct", "<cmd>CopilotChatTests<cr>", { desc = "Generate tests" })
map("v", "<leader>ct", "<cmd>CopilotChatTests<cr>", { desc = "Generate tests" })
map("n", "<leader>cm", "<cmd>CopilotChatCommit<cr>", { desc = "Generate commit message" })
