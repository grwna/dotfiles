local opt = vim.opt

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

opt.clipboard = ""

-- line numbering
opt.number = true 
opt.relativenumber = true 

-- searching
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- ui and view
opt.termguicolors = true    
opt.cursorline = true      
opt.scrolloff = 8         
opt.signcolumn = "yes"   
opt.laststatus = 3
