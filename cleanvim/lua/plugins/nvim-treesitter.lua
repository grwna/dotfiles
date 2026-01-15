return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = {"BufReadPre", "BufNewFile"},

        branch = "master",
        build = ':TSUpdate',
        
        -- MAIN VERSION (UNSTABLE)
        -- config = function ()
        --     require("nvim-treesitter").setup({})
        --     require("nvim-treesitter").install({
        --         "lua",
        --         "vim",
        --         "vimdoc",
        --         "python",
        --         "cpp",
        --         "c",
        --         "javascript",
        --         "html",
        --     })

        --     vim.api.nvim_create_autocmd("FileType", {
        --         callback = function()
        --             pcall(vim.treesitter.start)
        --         end,
        --     })

        --     vim.opt.foldmethod = "expr"
        --     vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

        --     vim.opt.foldlevel = 99
        --     vim.opt.foldlevelstart = 99
        -- end
        
        
        -- MASTER VERSION (STABLE)
        config = function ()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {
                 "lua",
                 "vim",
                 "vimdoc",
                 "python",
                 "cpp",
                 "c",
                 "javascript",
                 "html",
                },
                sync_install = false,
                auto_install = true,
                highlight = {enable = true},
                indent = {enable = true},
                ignore_install = {},
                modules = {},
            })
        end
    }
}
