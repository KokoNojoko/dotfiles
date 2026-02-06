-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- ================================
-- General
-- ================================
opt.confirm = true -- Confirm before closing unsaved buffers
opt.autowrite = true -- Auto save before commands like :next
opt.clipboard = "unnamedplus" -- Use system clipboard

-- ================================
-- UI
-- ================================
opt.number = true -- Show line numbers
opt.relativenumber = true -- Relative line numbers
opt.cursorline = true -- Highlight current line
opt.signcolumn = "yes" -- Always show sign column
opt.scrolloff = 8 -- Keep 8 lines visible above/below cursor
opt.sidescrolloff = 8 -- Keep 8 columns visible left/right

-- ================================
-- Indentation
-- ================================
opt.tabstop = 4 -- Tab = 4 spaces (common for C#)
opt.shiftwidth = 4 -- Indent = 4 spaces
opt.expandtab = true -- Use spaces instead of tabs
opt.smartindent = true -- Smart auto-indenting

-- ================================
-- Search
-- ================================
opt.ignorecase = true -- Ignore case in search
opt.smartcase = true -- Unless uppercase used

-- ================================
-- Splits
-- ================================
opt.splitright = true -- Open vertical splits to the right
opt.splitbelow = true -- Open horizontal splits below

-- ================================
-- Performance
-- ================================
opt.updatetime = 200 -- Faster completion
opt.timeoutlen = 300 -- Faster key sequence completion

-- ================================
-- File handling
-- ================================
opt.undofile = true -- Persistent undo
opt.swapfile = false -- No swap files
opt.backup = false -- No backup files

-- ================================
-- WSL/Terminal specific
-- ================================
if vim.fn.has("wsl") == 1 then
  -- WSL clipboard support
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end
