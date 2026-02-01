---@diagnostic disable: undefined-global
return {
    {
        "mason-org/mason-lspconfig.nvim",
        event = {"BufReadPre", "BufNewFile"},
        cmd = {"Mason"},
        opts = {
            ensure_installed = {
                "lua_ls",
                "pyright",
                "clangd",
            },
            automatic_installation = true,
        },

        config = function (_, opts)
            require("mason").setup()
            require("mason-lspconfig").setup(opts)

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
