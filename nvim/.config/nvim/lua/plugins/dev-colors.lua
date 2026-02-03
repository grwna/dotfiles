return {
	{
		"catgoose/nvim-colorizer.lua",
		ft = {
			"css",
			"html",
			"tsx",
			"jsx",
		},

		opts = {
            user_default_options = {
                tailwind = "both",
                tailwind_opts = { update_names = true },
                css = true,
                oklch_fn = true,
                mode = "background",
            }
		},
	},
	{
		"uga-rosa/ccc.nvim",
		keys = {
			{ "<leader>ccp", "<cmd>CccPick<cr>", desc = "CCC Picker" },
			{ "<leader>ccv", "<cmd>CccConvert<cr>", desc = "CCC Convert Format" },
		},
		config = function()
			local ccc = require("ccc")
			ccc.setup({
				highlighter = {
					auto_enable = false,
				},
				recognize = {
					input = true,
					output = true,
				},
				inputs = {
					ccc.input.oklch,
					ccc.input.rgb,
					ccc.input.hsl,
				},
				outputs = {
					ccc.output.css_oklch,
					ccc.output.hex,
					ccc.output.css_rgb,
				},
				convert = {
					{ ccc.picker.css_oklch, ccc.output.hex },
					{ ccc.picker.hex, ccc.output.css_rgb },
					{ ccc.picker.css_rgb, ccc.output.css_oklch },
				},
			})
		end,
	},
}
