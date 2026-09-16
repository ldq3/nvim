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
})

require("visuals")
require("language.mod")
require("complete")
require("ai")
require("utils")

