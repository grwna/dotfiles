return {
    {
        "EdenEast/nightfox.nvim",
        enabled = false,
        priority = 1000,
        -- config = function()
        --    require("nightfox").setup({})
        --    vim.cmd("colorscheme carbonfox")
        -- end,
        -- to see the list of variants, visit https://vimcolorschemes.com/edeneast/nightfox.nvim
    },
    {
        {
            "tiagovla/tokyodark.nvim",
            opts = {},
            config = function(_, opts)
                require("tokyodark").setup(opts) 
                vim.cmd("colorscheme tokyodark")
            end,
        }
    },
}

