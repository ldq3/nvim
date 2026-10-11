vim.pack.add({
    { src = "https://github.com/sphamba/smear-cursor.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },

    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = 'https://github.com/nvim-tree/nvim-tree.lua' },

    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/folke/which-key.nvim",

    "https://github.com/yetone/avante.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",

    "https://github.com/hrsh7th/nvim-cmp",
    "https://github.com/hrsh7th/cmp-nvim-lsp",
    "https://github.com/hrsh7th/cmp-buffer",
    "https://github.com/hrsh7th/cmp-path",
    "https://github.com/hrsh7th/cmp-cmdline",
    "https://github.com/L3MON4D3/LuaSnip",
    "https://github.com/saadparwaiz1/cmp_luasnip",
    "https://github.com/rafamadriz/friendly-snippets",

    "https://github.com/kdheepak/lazygit.nvim",
    "https://github.com/nvim-lualine/lualine.nvim",

    "https://github.com/SmiteshP/nvim-navic",
    "https://github.com/mfussenegger/nvim-dap",
    { src = "https://github.com/sindrets/diffview.nvim", name = "diffview" },

    "https://github.com/folke/lazydev.nvim",

    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/neovim/nvim-lspconfig",

    { src = "https://github.com/okuuva/auto-save.nvim", name = "auto-save" },
    { src = "https://github.com/stevearc/overseer.nvim", name = "overseer" },
    { src = "https://github.com/folke/trouble.nvim", name = "trouble" },
    { src = "https://github.com/lewis6991/gitsigns.nvim", name = "gitsigns"},
    { src = "https://github.com/epwalsh/obsidian.nvim", name = "obsidian" },
    { src = "https://github.com/Julian/lean.nvim" },
    { src = "https://github.com/hedyhli/outline.nvim" },
    { src = "https://github.com/chentoast/marks.nvim", name = "marks"},
    { src = "https://github.com/goropikari/tabflow.nvim" },
})


local utils = require("utils.mod")
utils.load_all_modules("start")


require("visuals")
require("find")
require("language.mod")
require("complete")

