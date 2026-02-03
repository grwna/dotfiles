return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-mini/mini.icons",
	},

	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Open nvim-tree" }, -- used by nvim-tree
	},

	config = function()
		local function my_on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- default mappings
			api.config.mappings.default_on_attach(bufnr)

			-- custom mappings
			-- vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up')) (example)
			vim.keymap.set("n", "L", api.node.open.edit, opts("Open"))
			vim.keymap.set("n", "N", api.node.open.toggle_group_empty, opts("Toggle Group Empty"))
			vim.keymap.set("n", "v", function ()
                local node = api.tree.get_node_under_cursor()
                api.marks.toggle(node)
			end, opts("Toggle Bookmarks"))
			vim.keymap.set("n", "V", api.marks.clear, opts("Clear All Bookmarks"))
		end

		require("nvim-tree").setup({
			hijack_netrw = false,
			on_attach = my_on_attach,
		})
	end,
}
