-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Basic keymappings (can be used on any neovim installation with no plugins)
vim.keymap.set("i", "kj", "<Esc>", { desc = "Exit Insert Mode" })
vim.keymap.set("i", "KJ", "<Esc>", { desc = "Exit Insert Mode" })
vim.keymap.set("v", "mn", "<Esc>", { desc = "Exit Visual Mode" })
vim.keymap.set("v", "MN", "<Esc>", { desc = "Exit Visual Mode" })

vim.keymap.set("n", "H", "^", { noremap = true, silent = true, desc = "Start of line (Home)" })
vim.keymap.set("n", "L", "$", { noremap = true, silent = true, desc = "End of line (End)" })

vim.keymap.set("v", "H", "^", { noremap = true, silent = true, desc = "Start of line (Home)" })
vim.keymap.set("v", "L", "$", { noremap = true, silent = true, desc = "End of line (End)" })

vim.keymap.set("o", "H", "^", { noremap = true, silent = true, desc = "Start of line (Home)" })
vim.keymap.set("o", "L", "$", { noremap = true, silent = true, desc = "End of line (End)" })

-- Window Management
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "Go to the left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "Go to the down window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "Go to the up window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "Go to the right window" })

vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { noremap = true, silent = true, desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { noremap = true, silent = true, desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { noremap = true, silent = true, desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { noremap = true, silent = true, desc = "Increase window width" })

-- terminal
vim.keymap.set("t", "<M-[>", "<C-\\><C-n>", {desc = "Exit terminal mode", nowait = true})

-- other
vim.keymap.set({"i", "v", "c"}, "<M-[>", "<Esc>", { desc = "Exit mode" })
vim.keymap.set("n", "<M-[>", "<cmd>nohlsearch<cr><Esc>", { desc = "Clear highlights / Escape" })

-- navigating wrapped lines
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
