-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Normal mode exit
vim.keymap.set("i", "kj", "<Esc>", { desc = "Exit Insert Mode" })
vim.keymap.set("v", "mn", "<Esc>", { desc = "Exit Visual Mode" })

vim.keymap.set("n", "H", "^", { noremap = true, silent = true, desc = "Start of line (Home)" })
vim.keymap.set("n", "L", "$", { noremap = true, silent = true, desc = "End of line (End)" })

vim.keymap.set("v", "H", "^", { noremap = true, silent = true, desc = "Start of line (Home)" })
vim.keymap.set("v", "L", "$", { noremap = true, silent = true, desc = "End of line (End)" })
