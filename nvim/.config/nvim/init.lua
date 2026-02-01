-- add custom folders
require("config.autocmds")
require("config.keymaps")
require("config.options")

-- bootstrap lazy.nvim
-- require("config.startup")
require("config.lazy")
require("config.lsp")

-- Disable standard clipboard option initially to prevent early probing
vim.opt.clipboard = ""

-- Hardcode the clipboard provider.
-- This completely bypasses the slow provider#clipboard#Executable() check.
if vim.fn.has("wsl") == 1 then
	vim.g.clipboard = {
		name = "win32yank-wsl",
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
		cache_enabled = 0,
	}
end

-- vim.opt.clipboard = "unnamedplus"

-- Fix Browser timeout issue
if vim.fn.has("wsl")==1 then
    vim.ui.open = function (path)
        vim.fn.jobstart({"wslview", path}, {detach = true})
    end
end

