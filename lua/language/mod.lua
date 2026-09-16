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

require("language.lua")
