return {
	{
        "grwna/just-do-it.nvim",
        cmd = "JustDoIt",
		keys = {
			{ "<leader>td", "<cmd>JustDoIt<cr>", desc = "Open Todo List" },
		},
		opts = {
			keymaps = { toggle_done = "<C-l>" },
		},
	},
}
