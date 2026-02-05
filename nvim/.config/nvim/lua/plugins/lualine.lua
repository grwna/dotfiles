-- https://github.com/nvim-lualine/lualine.nvim
return {
    {
        "nvim-lualine/lualine.nvim",
        enabled = not vim.g.vscode,
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
