local function list() return require("harpoon"):list() end
local function ui() return require("harpoon").ui end

return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {{"nvim-lua/plenary.nvim"}},

        opts = {
            settings = {
                -- these are defaults
                save_on_toggle = false,
                sync_on_ui_close = false,
                key = function()
                    return vim.loop.cwd()
                end,
            },
        },

        keys = {
            {"<leader>ha", function() list():add() end, desc = "Harpoon add file"},
            {"<leader>hl", function() ui():toggle_quick_menu(list()) end, desc = "Harpoon open list"},

            {"<leader>1", function() list():select(1) end, desc = "Harpoon 1", hidden = true},
            {"<leader>2", function() list():select(2) end, desc = "Harpoon 2", hidden = true},
            {"<leader>3", function() list():select(3) end, desc = "Harpoon 3", hidden = true},
            {"<leader>4", function() list():select(4) end, desc = "Harpoon 4", hidden = true},
        },
    },
}


