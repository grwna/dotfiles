return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-mini/mini.icons',
    },
    opts = {
        file_types = { "markdown", "Avante" },
        latex = {enabled = false},
    },
    ft = { "Avante", "markdown" },
    keys = {
        {
            "<leader>rm", 
             function()
                require("render-markdown").toggle()
                if vim.opt.conceallevel:get() ~= 2 then
                    vim.opt.conceallevel = 2
                end
            end,
            desc = "Toggle Markdown Render"},
    },
}

