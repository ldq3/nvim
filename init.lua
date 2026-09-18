vim.pack.add({
	{ src = "https://github.com/sphamba/smear-cursor.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },

	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = 'https://github.com/nvim-tree/nvim-tree.lua' },

	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/mason-org/mason.nvim",

	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/folke/which-key.nvim",

    "https://github.com/yetone/avante.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    "https://github.com/nvim-lua/plenary.nvim",

     "https://github.com/hrsh7th/nvim-cmp",
     "https://github.com/hrsh7th/cmp-nvim-lsp",
     "https://github.com/hrsh7th/cmp-buffer",
     "https://github.com/hrsh7th/cmp-path",
     "https://github.com/hrsh7th/cmp-cmdline",
     "https://github.com/L3MON4D3/LuaSnip",
     "https://github.com/saadparwaiz1/cmp_luasnip",
     "https://github.com/rafamadriz/friendly-snippets",

	 "https://github.com/jesseduffield/lazygit",
	 "https://github.com/nvim-lualine/lualine.nvim",

	 "https://github.com/SmiteshP/nvim-navic",
	 "https://github.com/mfussenegger/nvim-dap",
	 "https://github.com/sindrets/diffview.nvim",

	"https://github.com/folke/lazydev.nvim",
})

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

require("visuals")
require("language.lua")
require("language.mod")
require("complete")
require("ai")
require("utils")

