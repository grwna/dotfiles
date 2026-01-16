-- provides shortcuts like 'gcc' or 'gcb' to quickly comment lines or blocks
return {
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function()
            require("Comment").setup()
        end,
    }
}
