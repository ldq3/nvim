vim.lsp.config("lua_ls", {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = {
				globals = { "vim", "require" },
			},
			workspace = {
				-- library = vim.api.nvim_get_runtime_file("", true),  -- 这个配置会导致 lazydev 识别错误
				checkThirdParty = false, -- 交给lazydev接管第三方库
			},
			telemetry = { enable = false },
		},
	},
})

require("lazydev").setup({
    library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
})

