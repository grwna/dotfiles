---@diagnostic disable: undefined-global
return {
	{
		"mason-org/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "Mason" },
		opts = {
			ensure_installed = {
				"lua_ls",
				-- "pyright",
				"basedpyright",
				"clangd",
				"eslint",
				"ts_ls",
				"emmet_language_server",
			},
			automatic_installation = true,
		},

		config = function(_, opts)
			require("mason").setup()

			vim.diagnostic.config({
				virtual_text = true,
				underline = true,
			})

            for _, server in ipairs(opts.ensure_installed) do
                vim.lsp.enable(server)
            end
        end,

        dependencies = {
            {
                "mason-org/mason.nvim",
                opts = {
                    ui = {
                        icons = {
                            package_installed = "✓",
                            package_pending = "→",
                            package_uninstalled = "✗",
                        }
                    }
                },
            },

            {
                "neovim/nvim-lspconfig"
            }
        }
    },
}
