return {
    {
        'stevearc/conform.nvim',
        opts = {
            formatters_by_ft = {
                lua = {"stylua"},
                javascript = {"prettierd", "prettier", stop_after_first = true},
                python = {"ruff"},
            }
        },
        keys = {
            {"<leader>pr", function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end, desc = "Apply formatter to buffer"}
        },
    }
}
