return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-mini/mini.icons",
	},
	opts = {
		file_types = { "markdown", "Avante" },
		latex = { enabled = false },
	},
	ft = { "Avante", "markdown" },
	keys = {
		{ "<leader>rm", "<cmd>RenderMarkdown buf_toggle<cr>", desc = "Toggle Markdown Render" },
	},
}
