return {
	{
		"mason-org/mason-lspconfig.nvim",
        enabled = not vim.g.vscode and not vim.g.disable_lsp,
		event = {"BufReadPre", "BufNewFile"},
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
                "hls"
			},
			automatic_installation = true,
		},

		config = function(_, opts)
			require("mason").setup()
			require("mason-lspconfig").setup(opts)

			vim.diagnostic.config({
				virtual_text = {
					severity = { min = vim.diagnostic.severity.ERROR },
				},
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

				-- Configure lua_ls to work with lazydev
				if lsp_name == "lua_ls" then
					config.settings = {
						Lua = {
							completion = {
								callSnippet = "Replace"
							}
						}
					}
				end

                if lsp_name == "basedpyright" then
                    config.settings = {
                        basedpyright = {
                            analysis = {
                                typeCheckingMode = "off", 
                            },
                        },
                    }
                    config.handlers = {
                        ["textDocument/publishDiagnostics"] = function() end,
                    }
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
            },

            {
                "folke/lazydev.nvim",
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                    -- Enable for all Lua files (not just in config directory)
                    enabled = function(root_dir)
                        return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
                    end,
                },
            }
        }
    },
}
