-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

-- ================================
-- Quick Save
-- ================================
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- ================================
-- Better movement
-- ================================
-- Center screen after big jumps
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search result (centered)" })

-- ================================
-- Better editing
-- ================================
-- Move lines up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Keep cursor in place when joining lines
map("n", "J", "mzJ`z", { desc = "Join lines (cursor stays)" })

-- Paste without losing register
map("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting register" })

-- Delete to void register (using <leader>x to avoid conflict with DAP's <leader>d prefix)
map({ "n", "v" }, "<leader>x", [["_d]], { desc = "Delete to void register" })

-- ================================
-- Quick substitution
-- ================================
map("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })

-- ================================
-- Formatting
-- ================================
map({ "n", "v" }, "<A-S-f>", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file" })

-- ================================
-- Neo-tree
-- ================================
map("n", "<C-b>", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })

-- ================================
-- Quickfix navigation
-- ================================
map("n", "<leader>qn", "<cmd>cnext<cr>zz", { desc = "Next quickfix" })
map("n", "<leader>qp", "<cmd>cprev<cr>zz", { desc = "Prev quickfix" })

-- ================================
-- Terminal (better escape)
-- ================================
map("t", "<C-\\>", "<cmd>close<cr>", { desc = "Close terminal" })
