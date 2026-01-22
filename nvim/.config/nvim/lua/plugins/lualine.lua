-- https://github.com/nvim-lualine/lualine.nvim
return {
    {
        "nvim-lualine/lualine.nvim",
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
