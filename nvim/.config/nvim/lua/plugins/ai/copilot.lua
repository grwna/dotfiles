return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        enabled = not vim.g.vscode,

        keys = {
            {
                "<leader>ac",
                function ()
                    require("copilot.suggestion").toggle_auto_trigger()
                    -- workaround because copilot.lua doesn't have a native is_enabled flag
                    local is_enabled = vim.b.copilot_suggestion_auto_trigger

                    if is_enabled then
                       vim.notify("Copilot ON", vim.log.levels.INFO, { title = "Copilot" })
                    else
                       vim.notify("Copilot OFF", vim.log.levels.INFO, { title = "Copilot" })
                    end
                end,
                desc = "Toggle Copilot Completion",
            },
        },

        config = function()
            require("copilot").setup({
                suggestion = {
                    enabled = true,
                    auto_trigger = false,
                    debounce = 100,
                    keymap = {
                        accept = "<M-;>",
                    }
                },

                panel = {
                    enabled = false,
                },

                filetypes = {
                    ["*"] = true,
                },
                
                logger = {
                    print_log_level = vim.log.levels.OFF,
                },
            })

            -- for lualine copilot icon
            require("config.lualine.copilot-icon")
        end,
    }
}
