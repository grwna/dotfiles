return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
        },
        
        keys = {
            {
                "<leader>?",
                function ()
                    require("which-key").show({global = false})
                end,
                desc = "Local buffer keymaps",
            },
        },
    },
    -- refer to https://github.com/folke/which-key.nvim for how to create mappings
}
