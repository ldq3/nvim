vim.pack.add({
    -- A
    { src = "https://github.com/okuuva/auto-save.nvim", name = "auto-save" },

    -- B
    { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('^1') },

    -- C
    { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
    -- { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    -- { src = "https://github.com/hrsh7th/cmp-buffer" },
    -- { src = "https://github.com/hrsh7th/cmp-path" },
    -- { src = "https://github.com/hrsh7th/cmp-cmdline" },
    -- { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
    { src = "https://github.com/olimorris/codecompanion.nvim" },

    -- D
    { src = "https://github.com/sindrets/diffview.nvim", name = "diffview" },

    -- E
    { src =  "https://github.com/folke/edgy.nvim" },

    -- F
    { src = "https://github.com/rafamadriz/friendly-snippets" },

    -- G
    { src = "https://github.com/lewis6991/gitsigns.nvim", name = "gitsigns"},

    -- H
    { src = "https://github.com/rebelot/heirline.nvim" },

    -- L
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    { src = "https://github.com/kdheepak/lazygit.nvim" },
    { src = "https://github.com/folke/lazydev.nvim" },
    { src = "https://github.com/Julian/lean.nvim" },

    -- M
    { src = "https://github.com/ColinKennedy/mega.cmdparse" },
    { src = "https://github.com/ColinKennedy/mega.logging" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
    { src = "https://github.com/jay-babu/mason-nvim-dap.nvim" },

    -- N
    { src = "https://github.com/folke/noice.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
    { src = "https://github.com/MunifTanjim/nui.nvim" },
    -- { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/SmiteshP/nvim-navic" },
    { src = "https://github.com/mfussenegger/nvim-dap" },
    { src = "https://github.com/rcarriga/nvim-dap-ui" },
    { src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
    { src = "https://github.com/neovim/nvim-lspconfig" },

    -- O
    { src = "https://github.com/stevearc/overseer.nvim", name = "overseer" },  -- TODO: 配置
    { src = "https://github.com/epwalsh/obsidian.nvim", name = "obsidian" },
    { src = "https://github.com/hedyhli/outline.nvim" },

    -- P
    { src = "https://github.com/nvim-lua/plenary.nvim" },

    -- R
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },

    -- S
    { src = "https://github.com/sphamba/smear-cursor.nvim" },

    -- T
    { src = "https://github.com/goropikari/tabflow.nvim" },
    { src = "https://github.com/LukasPietzschmann/telescope-tabs" },  -- TODO: 替换
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/folke/todo-comments.nvim" },
    { src = "https://github.com/folke/trouble.nvim", name = "trouble" },

    -- W
    { src = "https://github.com/folke/which-key.nvim" },
})


require("plugin.mod")
require("ui.mod")
require("visuals")
require("language.mod")

