local lspconfig = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('neodev').setup()

lspconfig.tsserver.setup {}
lspconfig.rust_analyzer.setup {}

-- Lua
lspconfig.lua_ls.setup {
    capabilities = capabilities,
	root_dir = function()
        return vim.loop.cwd()
    end,
	cmd = { "lua-lsp" },
    settings = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    }
}

-- Nix lsp
lspconfig.rnix.setup {
    capabilities = capabilities,
}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
	  local bufmap = function(keys, func)
	    vim.keymap.set('n', keys, func, { buffer = ev.buf })
	  end

	  bufmap('<leader>r', vim.lsp.buf.rename)
	  bufmap('<leader>a', vim.lsp.buf.code_action)

	  bufmap('gd', vim.lsp.buf.definition)
	  bufmap('gD', vim.lsp.buf.declaration)
	  bufmap('gI', vim.lsp.buf.implementation)
	  bufmap('<leader>D', vim.lsp.buf.type_definition)

	  bufmap('K', vim.lsp.buf.hover)

	  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
	    vim.lsp.buf.format()
	  end, {})
  end,
})
