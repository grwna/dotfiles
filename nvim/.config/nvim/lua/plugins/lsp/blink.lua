return {
	"saghen/blink.cmp",
    -- enabled = false,
	version = "v1.7",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"Kaiser-Yang/blink-cmp-avante",
	},

	opts = {
		keymap = {
			preset = "default",
			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-h>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<CR>"] = { "accept", "fallback" },
		},

		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},

		completion = {
			accept = { auto_brackets = { enabled = true } },
			documentation = { auto_show = false, auto_show_delay_ms = 500 },
			menu = {
				draw = {
					columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
				},
			},
			trigger = {
				prefetch_on_insert = false,
			},
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer", "avante" },
			providers = {
				avante = {
					module = "blink-cmp-avante",
					name = "Avante",
					opts = {},
				},
				lsp = {
					score_offset = 100,
					fallbacks = { "buffer" },
					timeout_ms = 100,
					async = true,
					max_items = 30,
				},
			},
		},

		fuzzy = {
			implementation = "prefer_rust_with_warning",
			prebuilt_binaries = { download = true },
		},
		signature = { enabled = true },
	},
}
