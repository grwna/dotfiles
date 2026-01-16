-- this is a table entry
-- the entry will be used within 'lazy.lua' under 'require("lazy").setup({})'
return {
    {
        "template_username/template_repository",
        enabled = false,
        lazy = false,
        config = function()
            require("plugin_name").setup(
                {}
            )
        end,
    }   
}
