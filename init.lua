vim.pack.add({
    { src = "https://github.com/okuuva/auto-save.nvim", name = "auto-save" },
    { src = "https://github.com/yetone/avante.nvim", },

    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/hrsh7th/cmp-buffer" },
    { src = "https://github.com/hrsh7th/cmp-path" },
    { src = "https://github.com/hrsh7th/cmp-cmdline" },

    { src = "https://github.com/sindrets/diffview.nvim", name = "diffview" },

    { src =  "https://github.com/folke/edgy.nvim" },

    { src = "https://github.com/folke/noice.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
    { src = "https://github.com/MunifTanjim/nui.nvim" },
    { src = "https://github.com/hrsh7th/nvim-cmp" },

    { src = "https://github.com/nvim-lua/plenary.nvim" },

    { src = "https://github.com/sphamba/smear-cursor.nvim" },

    { src = "https://github.com/nvim-telescope/telescope.nvim" },


    "https://github.com/folke/which-key.nvim",

    "https://github.com/MeanderingProgrammer/render-markdown.nvim",

    "https://github.com/L3MON4D3/LuaSnip",
    "https://github.com/saadparwaiz1/cmp_luasnip",
    "https://github.com/rafamadriz/friendly-snippets",

    "https://github.com/kdheepak/lazygit.nvim",

    "https://github.com/SmiteshP/nvim-navic",
    "https://github.com/mfussenegger/nvim-dap",

    "https://github.com/folke/lazydev.nvim",

    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/neovim/nvim-lspconfig",

    { src = "https://github.com/stevearc/overseer.nvim", name = "overseer" },
    { src = "https://github.com/folke/trouble.nvim", name = "trouble" },
    { src = "https://github.com/lewis6991/gitsigns.nvim", name = "gitsigns"},
    { src = "https://github.com/epwalsh/obsidian.nvim", name = "obsidian" },
    { src = "https://github.com/Julian/lean.nvim" },
    { src = "https://github.com/hedyhli/outline.nvim" },
    { src = "https://github.com/chentoast/marks.nvim", name = "marks"},
    { src = "https://github.com/goropikari/tabflow.nvim" },
    { src = "https://github.com/rebelot/heirline.nvim" },
    { src = "https://github.com/LukasPietzschmann/telescope-tabs" },
})


require("plugin.mod")

-- normal
-- q: 开始录制宏
-- Q: 
-- w: 

require("ui.mod")
require("visuals")
require("find")
require("language.mod")
require("complete")

