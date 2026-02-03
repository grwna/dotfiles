-- snatched directly from https://github.com/josean-dev/dev-environment-files
local keymap = vim.keymap -- for conciseness
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf, silent = true }

		-- set keybinds
		opts.desc = "Show LSP references"
		keymap.set("n", "gR", function()
			Snacks.picker.lsp_references()
		end, opts)

		opts.desc = "Show LSP implementations"
		keymap.set("n", "gi", function()
			Snacks.picker.lsp_implementations()
		end, opts)

		opts.desc = "Show LSP type definitions"
		keymap.set("n", "gt", function()
			Snacks.picker.lsp_type_definitions()
		end, opts)

		opts.desc = "Show buffer diagnostics"
		keymap.set("n", "<leader>D", function()
			Snacks.picker.diagnostics_buffer()
		end, opts)

		-- Standard LSP functions (no change needed)
		opts.desc = "Go to declaration"
		keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

		opts.desc = "Show LSP definition"
		keymap.set("n", "gd", vim.lsp.buf.definition, opts)

		opts.desc = "See available code actions"
		keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

		opts.desc = "Smart rename"
		keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

		opts.desc = "Show line diagnostics"
		keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

		opts.desc = "Go to previous diagnostic"
		keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts)

		opts.desc = "Go to next diagnostic"
		keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts)

		opts.desc = "Show documentation"
		keymap.set("n", "K", vim.lsp.buf.hover, opts)

		opts.desc = "Restart LSP"
		keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
	end,
})

-- vim.lsp.inlay_hint.enable(true)

local severity = vim.diagnostic.severity
vim.diagnostic.config({
	signs = {
		text = {
			-- [severity.ERROR] = " ",
			-- [severity.WARN] = " ",
			-- [severity.HINT] = "󰠠 ",
			-- [severity.INFO] = " ",
		},
	},
})

local original_publish_diagnostics = vim.lsp.handlers["textDocument/publishDiagnostics"]
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  
  if client and (client.name == "ts_ls" or client.name == "typescript") then
    result.diagnostics = vim.tbl_filter(function(d)
      return d.code ~= 6133 and d.code ~= 6192
    end, result.diagnostics)
  end

  original_publish_diagnostics(err, result, ctx, config)
end
