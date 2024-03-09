local lualine = require("lualine")
local lsp_progress = require("lsp-progress")

-- listen lsp-progress event and refresh lualine
lsp_progress.setup({})

vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
	group = "lualine_augroup",
	pattern = "LspProgressStatusUpdated",
	callback = lualine.refresh,
})

-- Setup lualine
lualine.setup({
	sections = {
		lualine_c = {
			lsp_progress.progress,
		},
	},
})
