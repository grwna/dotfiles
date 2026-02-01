return {
    {
        "EdenEast/nightfox.nvim",
        priority = 1000,
        config = function()
           require("nightfox").setup({})
           vim.cmd("colorscheme carbonfox")

            -- Force a strong underline (sp = special color for underline)
            vim.api.nvim_set_hl(0, "LspReferenceText", { underline = true, sp = "#61afef", bold = false })
            vim.api.nvim_set_hl(0, "LspReferenceRead", { underline = true, sp = "#61afef", bold = false })
            vim.api.nvim_set_hl(0, "LspReferenceWrite", { underline = true, sp = "#61afef", bold = false })
        end,
        -- to see the list of variants, visit https://vimcolorschemes.com/edeneast/nightfox.nvim
    },

}

