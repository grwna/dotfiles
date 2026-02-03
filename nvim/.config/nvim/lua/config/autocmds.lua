-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

------------------------------
--- DISABLE NETRW HIJACKING
------------------------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function(data)
		local directory = vim.fn.isdirectory(data.file) == 1
		if directory then
			vim.cmd("bwipeout")
			vim.cmd("enew")
			vim.cmd("cd " .. data.file)
		end
	end,
})

------------------------------
--- ENABLE AUTOREAD
------------------------------
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
	command = "if mode() != 'c' | checktime | endif",
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
	callback = function()
		vim.notify("File changed on disk. Buffer reloaded!", vim.log.levels.WARN, { title = "System" })
	end,
})

------------------------------
--- ENABLE AUTO-SAVE
------------------------------
--- Autosaves when leaving buffer or moving windows
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave", "InsertLeave" }, {
	callback = function()
		if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
			vim.cmd("silent! update")
		end
	end,
})

--------------------------------------------
--- DISABLE NUMBER LINE FOR TERMINALS
--- -----------------------------------------
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		if vim.opt.buftype:get() == "terminal" then
			vim.opt_local.number = false
			vim.opt_local.relativenumber = false
		end
	end,
})

--------------------------------------------
--- THEME RELATED COMMANDS
--- -----------------------------------------
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		local hl = vim.api.nvim_get_hl(0, { name = "@function", link = false })
		vim.api.nvim_set_hl(0, "WinSeparator", { fg = hl.fg, bold = true })
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	desc = "Prevent themes from clearing LSP reference underlines",
	callback = function()
		local hl_groups = { "LspReferenceText", "LspReferenceRead", "LspReferenceWrite" }
		for _, group in ipairs(hl_groups) do
			vim.api.nvim_set_hl(0, group, {
				underline = true,
				sp = "#61afef",
				bold = false,
			})
		end
	end,
})
