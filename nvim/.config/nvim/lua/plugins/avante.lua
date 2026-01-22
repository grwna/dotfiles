return {
    {
        -- https://github.com/yetone/avante.nvim
        "yetone/avante.nvim",
        lazy = true,
        version = false,
        build = "make",

        cmd = {
            "AvanteAsk", "AvanteChat", "AvanteEdit", "AvanteToggle",
        },

        keys = {
            {"<leader>aa", function() require("avante.api").ask() end, mode = {"n", "v"}, desc = "avante: ask"},
            {"<leader>ae", function() require("avante.api").edit() end, mode = {"v"}, desc = "avante: edit"},
            {"<leader>at", function() require("avante.api").toggle() end, mode = {"n", "v"}, desc = "avante: toggle"},
            {
                "<leader>ab",
                function()
                   local avante_api = require("avante.api")
                   local current_file = vim.fn.expand("%:p")
                   if current_file ~= "" then
                      avante_api.ask()
                      avante_api.add_selected_file(current_file)
                   end
                end,
                desc = "avante: add buffer to chat",
            },
        },

        opts = {
            provider = "copilot",
            auto_suggestion_provider = nil,

            input = { provider = "snacks", },

            mappings = {
                files = {
                   add_current = "<leader>am",
                },
            },
        },
        
        dependencies = {
            "MunifTanjim/nui.nvim", -- sidebar ui
            "MeanderingProgrammer/render-markdown.nvim", -- sidebar ui
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
            "zbirenbaum/copilot.lua",
            "folke/snacks.nvim",
        },
    }
} 
