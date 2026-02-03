-- trash is located at /home/grwna/.local/share/cleanvim/mini.files/trash
return {
    {
        "nvim-mini/mini.files",
        version = false,
        keys = {
            -- {"<leader>e", function() require("mini.files").open() end, desc = "Open mini.files explorer"}, -- used by nvim-tree
            {"<leader>E", function() require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
                end, desc = "Open mini.files explorer to current buffer"}
        },
        opts = {
            windows = {
                preview = true,
                width_focus = 30,
                width_nofocus = 20,
                width_preview = 50,
            },

            options = {
                use_as_default_explorer = false,
                permanent_delete = false,
            },
            -- default
            mappings = {
                close       = 'q',
                go_in       = 'l',
                go_in_plus  = 'L',
                go_out      = 'H',
                go_out_plus = 'h',
                mark_goto   = "'",
                mark_set    = 'm',
                reset       = ',', -- default <BS>
                reveal_cwd  = '.', -- default @
                show_help   = 'g?',
                synchronize = 'Y', -- default =
                trim_left   = '<',
                trim_right  = '>',
            },
        },

        config = function (_, opts)
            require("mini.files").setup(opts)
            vim.api.nvim_create_user_command("Trash", function ()
                local trash = vim.fn.stdpath("data") .. "/mini.files/trash"
                print(trash)
            end, {})
        end
    }
}
