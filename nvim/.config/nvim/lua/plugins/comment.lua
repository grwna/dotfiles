-- provides shortcuts like 'gcc' or 'gcb' to quickly comment lines or blocks
return {
    {
        "numToStr/Comment.nvim",
        enabled = not vim.g.vscode,
        event = "VeryLazy",
        config = function()
            require("Comment").setup()
        end,
    }
}
