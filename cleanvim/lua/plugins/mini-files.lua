return {
    {
        "nvim-mini/mini.files",
        version = false,
        lazy = false,
        keys = {
            {"<leader>e", function() require("mini.files").open() end,}
        },
        opts = {
            windows = {
                preview = true,
                width_focus = 30,
                width_nofocus = 20,
                width_preview = 50,
            },

            options = {
                use_as_default_explorer = true,
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
                synchronize = 's', -- default =
                trim_left   = '<',
                trim_right  = '>',
            },
        },
    }
}
