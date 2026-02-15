-- https://github.com/nvim-lualine/lualine.nvim
return {
	{
		"nvim-lualine/lualine.nvim",
		enabled = not vim.g.vscode and not vim.g.disable_lsp,
		event = "VeryLazy",
		dependencies = {
			"nvim-mini/mini.icons",
		},

		config = function()
			local function custom_breadcrumbs()
				-- relative path
				local path = vim.fn.expand("%:.~")
				-- Replace '/' with ' > '
				local breadcrumb = path:gsub("/", " > ")
                local max_len = 40
                if #breadcrumb > max_len then
                    return "..." .. string.sub(breadcrumb, -37)
                end
				return breadcrumb
			end

			require("lualine").setup({
				sections = {
					lualine_c = {
						{
							custom_breadcrumbs,
							-- color = { gui = "italic" },
                            color = "@comment.note"
						},
					},
				},
			})
			vim.opt.cmdheight = 0
		end,
	},
}
