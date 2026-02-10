return {
	{
		"goolord/alpha-nvim",
		dependencies = { 'nvim-mini/mini.icons' },
        cmd = {
            "Alpha"
        },

        
        
		config = function()
			local startify = require("alpha.themes.startify")
			startify.file_icons.provider = "mini"
			require("alpha").setup(startify.config)
		end,
	},
}
