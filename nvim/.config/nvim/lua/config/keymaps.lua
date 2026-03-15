-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<localleader>f", ":FzfLua grep<Enter>")
vim.keymap.set("n", "<localleader>;", ":FzfLua files<Enter>")
vim.keymap.set("n", "<localleader>s", ":FzfLua grep_cword<Enter>")
vim.keymap.set("n", "<localleader>b", ":FzfLua buffers<Enter>")
vim.keymap.set("n", "<localleader>y", ":YankyRingHistory<Enter>")

vim.keymap.set({"n", "v"}, "<Up>", function() print("Use k") end)
vim.keymap.set({"n", "v"}, "<Down>", function() print("Use j") end)
vim.keymap.set({"n", "v"}, "<Left>", function() print("Use h") end)
vim.keymap.set({"n", "v"}, "<Right>", function() print("Use l") end)

vim.keymap.set({"n", "v"}, "m", "10j")
vim.keymap.set({"n", "v"}, ",", "10k")
