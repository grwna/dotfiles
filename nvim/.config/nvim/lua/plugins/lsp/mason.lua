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
                "tailwindcss",
                "cssls",
			},
			automatic_installation = true,
		},

		config = function(_, opts)
			require("mason").setup()
			require("mason-lspconfig").setup(opts)

			vim.diagnostic.config({
				virtual_text = true,
				underline = true,
			})

			local lspconfig = require("lspconfig")
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- Manual mapping for servers where Mason name != lspconfig name
			local mapping = {
				ts_ls = "tsserver",
			}

			local function is_supported(server)
				local status, _ = pcall(require, "lspconfig.server_configurations." .. server)
				return status
			end

			for _, server in ipairs(opts.ensure_installed) do
				local lsp_name = mapping[server] or server
				
				local config = {
					capabilities = vim.deepcopy(capabilities),
				}

				if lsp_name == "cssls" then
					config.capabilities = vim.tbl_deep_extend("force", config.capabilities, {
						textDocument = {
							completion = {
								completionItem = {
									snippetSupport = true,
								},
							},
						},
					})
				end

				-- Only setup if lspconfig actually has the configuration
				if is_supported(lsp_name) then
					lspconfig[lsp_name].setup(config)
				end
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
