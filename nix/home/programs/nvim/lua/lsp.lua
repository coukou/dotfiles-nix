local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("neodev").setup()

lspconfig.tsserver.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.astro.setup({})

-- Lua
lspconfig.lua_ls.setup({
	capabilities = capabilities,
	root_dir = function()
		return vim.loop.cwd()
	end,
	settings = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
})

-- Nix lsp
lspconfig.nil_ls.setup({})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local bufmap = function(keys, desc, func)
			vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = desc })
		end

		bufmap("<leader>r", "LSP Rename", vim.lsp.buf.rename)
		bufmap("<leader>a", "Code action", vim.lsp.buf.code_action)

		bufmap("gd", "Go to definition", vim.lsp.buf.definition)
		bufmap("gD", "Go to declaration", vim.lsp.buf.declaration)
		bufmap("gI", "Go to implementation", vim.lsp.buf.implementation)
		bufmap("<leader>D", "Type definition", vim.lsp.buf.type_definition)

		bufmap("K", "LSP Hover", vim.lsp.buf.hover)

		require("lsp_signature").on_attach({
			bind = true,
			handler_opts = {
				border = "rounded",
			},
		}, ev.bufnr)
	end,
})
