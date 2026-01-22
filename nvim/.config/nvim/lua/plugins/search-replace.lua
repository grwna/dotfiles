return {
    {
        "roobert/search-replace.nvim",
        config = function()
            require("search-replace").setup(
                {
                    default_replace_single_buffer_options = "gcI",
                    default_replace_multi_buffer_options = "egcI",
                }
            )
            vim.o.inccommand = "split"
        end,
        keys = {
            { "<leader>srw", "<cmd>SearchReplaceSingleBufferCWord<cr>", desc = "Replace occurences of word under cursor" },
            { "<leader>srs", "<cmd>SearchReplaceSingleBufferOpen<cr>", desc = "Search and Replace" },
            { "<leader>srs", mode = {"v"}, "<cmd>SearchReplaceSingleBufferVisualSelection<cr>", desc = "Search and Replace Visual Selection" },
            { "<leader>srb", "<cmd>SearchReplaceMultiBufferCWord<cr>", desc = "Replace occurences of word under cursor (multi buffer)" },
        }
    }
}
