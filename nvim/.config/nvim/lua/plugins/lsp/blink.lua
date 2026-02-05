return {
	"saghen/blink.cmp",
	enabled = not vim.g.vscode,
	version = "v1.7",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"Kaiser-Yang/blink-cmp-avante",
		{
			"L3MON4D3/LuaSnip",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()

                -- load custom snippets
				require("luasnip.loaders.from_vscode").lazy_load({
					paths = { vim.fn.expand("~/.config/nvim/snippets") }
				})
			end,
		},
	},

	opts = {
		snippets = {
			preset = "luasnip",
		},

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
					fallbacks = { "buffer" },
					timeout_ms = 100,
					async = true,
					max_items = 8,
				},
				snippets = {
					max_items = 4,
					min_keyword_length = 2,
					-- only show exact matches for snippets
					-- transform_items = function(ctx, items)
					-- 	local keyword = ctx.get_keyword()
					-- 	return vim.tbl_filter(function(item)
					-- 		return string.find(item.label, "^" .. keyword) ~= nil
					-- 	end, items)
					-- end,
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
