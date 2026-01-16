-- snacks is a mega plugins that includes:
-- NOTE: these are the ones i'm using, snacks have features that i'm not using (e.g. explorer), each unused features will be commented
-- notifications
-- indent-lines
-- pickers (telescope)
return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        event = "VeryLazy",
        ---@type snacks.Config
        opts = {
            -- core utillities
            bigfile = { enabled = true},
            quickfile = {enabled = true},
            bufdelete = {enabled = true}, -- close buffers without closing windows
            scope = {enabled = true},
            git = {enabled = true},
            gitbrowse = {enabled = true}, -- quickly open lines in github
            lazygit = {enabled = true},
            rename = {enabled = true}, -- file renames (imports or references)
            words = {enabled = true},  -- highlights references of the word under cursor

            -- UI
            picker = require("config.snacks.picker"),
            -- dashboard = require("config.snacks.notifier"),
            indent = {enabled = true},
            input = {enabled = true},
            notifier = {enabled = true},
            -- statuscolumn = {enabled = true},
            -- explorer = {enabled = true},
            -- terminal = {enabled = true},
            toggle = {enabled = true}, -- add toggles logic

            -- other utillities
            -- animate = {enabled = true},
            -- scroll = {enabled = true},
            -- dim = {enabled = true},
            -- zen = {enabled = true},
            -- image = {enabled = true},
            -- profiler = {enabled = true},
            -- debug = {enabled = true},
            -- scratch = {enabled = true},

        },

        keys = {
            { "<leader>ft", function() Snacks.picker.pickers() end, desc = "List All Pickers" },
            { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
            { "<leader>fF", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
            { "<leader>fg", function() Snacks.picker.grep() end, desc = "Find Text" },
            { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find Buffers" },
            { "<leader>fr", function() Snacks.picker.resume() end, desc = "Resume Picker" },
            
            -- Extra Keys
            -- { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Open in Browser" },
            { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
            { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete All Other Buffer" },
            { "<leader>lg", function() Snacks.lazygit() end, desc = "Open Lazygit" },

          }
    }
}
