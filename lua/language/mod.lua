vim.diagnostic.config({
  virtual_text = { prefix = "●" },
  underline = true,
  signs = true,
  update_in_insert = false,
})

vim.pack.add({
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/mason-org/mason.nvim",
})

-- enable mason and configure icons
require("mason").setup({ -- setup is required
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"pyright",
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
	},
})

vim.lsp.config("lua_ls", {
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

vim.lsp.enable("lua_ls")

require("language.lua")
