-- https://github.com/nvim-lualine/lualine.nvim
return {
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        dependencies = {
            "echasnovski/mini.icons",
        },
        config = function()
            require("lualine").setup(
                {}
            )
            vim.opt.cmdheight = 0
        end,
    }   
}
