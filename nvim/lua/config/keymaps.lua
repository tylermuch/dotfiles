-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<localleader>f", ":FzfLua grep<Enter>")
vim.keymap.set("n", "<localleader>;", ":FzfLua files<Enter>")
vim.keymap.set("n", "<localleader>s", ":FzfLua grep_cword<Enter>")
vim.keymap.set("n", "<localleader>b", ":FzfLua buffers<Enter>")
