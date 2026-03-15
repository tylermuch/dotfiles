-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- tell lazyvim to use fzf instead of the default (telescope)
vim.g.lazyvim_picker = "fzf"
-- disable automatic formatting on save
vim.g.autoformat = false
-- show both relative and absolute line numbers
vim.opt.relativenumber = true
vim.opt.number = true
-- wrap long lines
vim.opt.wrap = true
-- show a column at 120 characters as a guide for long lines
vim.opt.colorcolumn = '120'
-- yanks stay in vim's registers, not synced to system clipboard
vim.opt.clipboard = ""
-- a tab is 4 spaces
vim.opt.tabstop = 4
-- >> / << indents by 4 spaces
vim.opt.shiftwidth = 4
-- pressing tab inserts spaces
vim.opt.expandtab = true
-- makes tab at line start use shiftwidth instead of tabstop
vim.opt.smarttab = true
-- new lines inherit indentation from the previous line
vim.opt.autoindent = true
-- context-aware indentation (e.g. after {)
vim.opt.smartindent = true
-- highlight all search matches
vim.opt.hlsearch = true
-- disables creating backup files
vim.opt.backup = false
-- keep 10 lines of context above/below cursor when scrolling
vim.opt.scrolloff = 10
