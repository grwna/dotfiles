return {
    {
        'stevearc/conform.nvim',
        enabled = not vim.g.vscode,
        opts = {
            formatters_by_ft = {
                lua = {"stylua"},
                javascript = {"prettierd", "prettier", stop_after_first = true},
                python = {"ruff"},
                cpp = {"clang-format"},
            },
            formatters = {
                ["clang-format"] = {
                    prepend_args = {"--style={IndentWidth: 4}"},
                },
            },

            format_on_save = {
                lsp_format = "fallback",
                timeout_ms = 500,
            },

        },
        keys = {
            {"<leader>pr", function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end, desc = "Apply formatter to buffer"}
        },
    }
}
