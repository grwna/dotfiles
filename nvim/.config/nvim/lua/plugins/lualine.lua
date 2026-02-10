-- https://github.com/nvim-lualine/lualine.nvim
return {
    {
        "nvim-lualine/lualine.nvim",
        enabled = not vim.g.vscode and not vim.g.disable_lsp,
        event = "VeryLazy",
        dependencies = {
            "nvim-mini/mini.icons",
        },
        config = function()
            require("lualine").setup(
                {}
            )
            vim.opt.cmdheight = 0
        end,
    }   
}
