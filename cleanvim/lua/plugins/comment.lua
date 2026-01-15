-- provides shortcuts like 'gcc' or 'gcb' to quickly comment lines or blocks
return {
    {
        "numToStr/Comment.nvim",
        lazy = false,
        config = function()
            require("Comment").setup()
        end,
    }
}
