return {
	{
		"tiagovla/tokyodark.nvim",
		opts = {
			custom_highlights = function(highlights, palette)
				return {
					Comment = { fg = "#7a88cf", italic = true },
				}
			end,
			gamma = 1.10,
		},
		config = function(_, opts)
			require("tokyodark").setup(opts)
			vim.cmd("colorscheme tokyodark")
		end,
	},
	{
		"folke/tokyonight.nvim",
		enabled = false,
		opts = {},
		config = function(_, opts)
			require("tokyodark").setup(opts)
			-- vim.cmd("colorscheme tokyonight")
		end,
	},
}
