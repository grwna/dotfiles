return {
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        config = function()
            require("kanagawa").setup({
                theme = "wave",
                background = {
                    dark = "wave",
                    light = "lotus",
                },
            })
           vim.cmd("colorscheme kanagawa")
        end,
    },
    {
        "EdenEast/nightfox.nvim",
        priority = 1000,
        config = function()
           require("nightfox").setup({})
           vim.cmd("colorscheme carbonfox")
        end,
        -- to see the list of variants, visit https://vimcolorschemes.com/edeneast/nightfox.nvim
    },

}

