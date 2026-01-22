return {
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

