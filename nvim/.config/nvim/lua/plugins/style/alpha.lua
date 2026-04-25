return {
	{
		"nhattVim/alpha-ascii.nvim",
		lazy = false,
		opts = {
			header = "random",
			use_default = false,
			user_path = "~/.config/nvim/lua/config/art",
		},
		keys = {
			{ "<leader>zz", "<cmd>:AlphaAsciiNext<cr>", desc = "Next Header" },
		},
	},
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		cmd = { "Alpha" },
		dependencies = {
			{
				"nhattVim/alpha-ascii.nvim",
				"folke/persistence.nvim",
			},
		},
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")
			local ok, ascii = pcall(require, "alpha-ascii")

			if ok then
				local header_data = ascii.get_header()
				dashboard.section.header.val = header_data
			end

			dashboard.section.buttons.val = {
				dashboard.button("n", "  New File", ":ene<CR>"),
				dashboard.button("s", "  Restore Last Session", ":lua require('persistence').load()<CR>"),
				dashboard.button("S", "  Open Sessions List", ":lua require('persistence').select()<CR>"),
				dashboard.button("c", "󰣖  Open Configs", ":cd ~/.config/nvim | e init.lua<CR>"),
				dashboard.button("q", "󰈆  Exit Neovim", ":q<CR>"),
			}

			local datetime = {
				type = "text",
				val = os.date("%A, %B %d — %H:%M"),
				opts = { hl = "@comment.warning", position = "center" },
			}

			local border_line = string.rep("─", 54)
			local top_border = {
				type = "text",
				val = "╭" .. border_line .. "╮",
				opts = { hl = "String", position = "center" },
			}
			local bottom_border = {
				type = "text",
				val = "╰" .. border_line .. "╯",
				opts = { hl = "String", position = "center" },
			}

			dashboard.config.layout = {
				{ type = "padding", val = 2 },
				dashboard.section.header,
				{ type = "padding", val = 2 },
                {
                    type = "text",
                    val = require('config.art.title'),
                    opts = {hl ="@annotation", position = "center"},
                },
				{ type = "padding", val = 2 },
				datetime,
				{ type = "padding", val = 1 },
				top_border,
				{ type = "padding", val = 1 },
				{
					type = "group",
					val = dashboard.section.buttons.val,
					opts = {
						spacing = 1,
					},
				},
				bottom_border,
				{ type = "padding", val = 1 },

				dashboard.section.footer,
			}

			alpha.setup(dashboard.config)

			 vim.schedule(function ()
			     if vim.bo.filetype == "alpha" then
			         vim.cmd("AlphaAsciiRandom")
			     end
			end)
		end,
	},
}
