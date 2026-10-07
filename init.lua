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
    -- "https://github.com/nvim-lua/plenary.nvim",

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
    { src = "https://github.com/tpope/vim-fugitive", name = "fugitive" },
    { src = "https://github.com/epwalsh/obsidian.nvim", name = "obsidian" },

    { src = "https://github.com/Julian/lean.nvim" },
    { src = "https://github.com/hedyhli/outline.nvim"}
})


---@diagnostic disable-next-line: unused-local, unused-function
local function try(fn)
  local ok, err = pcall(fn)
  if not ok then
    vim.notify(string.format("[Config Error] %s", err), vim.log.levels.ERROR)
  end
end

require("outline").setup({
    outline_window = {
        position = "right", -- 右侧窗口，和Obsidian桌面版大纲位置一致
        width = 25,
    },
    symbol_folding = {
        autofold_depth = 1, -- 默认折叠H2以下
        auto_unfold = { hovered = true },
    },
    providers = {
        markdown = {
        -- 识别ATX标题 # ## ###
            show_numbers = true,
        }
    }
})

vim.keymap.set("n", "<space>o", "<cmd>Outline<CR>", { desc = "Toggle outline heading tree" })

vim.g.lean_config = { mappings = true }
require("diffview").setup({})
require("overseer").setup({})
require("trouble").setup({})
require("lazygit")
vim.opt.conceallevel = 1
vim.opt.concealcursor = "n"
require("obsidian").setup({
    workspaces = {
        { name = "self", path = "/mnt/d/kms/self/" }
    },
    picker = {
        name = "telescope.nvim",
        note_mappings = {
            new = "<C-x>",
            insert_link = "<C-l>",
            bookmark = "<C-b>",
        },
        tag_mappings = {
            tag_note = "<C-x>",
            insert_tag = "<C-l>",
        },
    }
})

-- you will most likely also need plenary dependency if you are manually managing packages:
-- vim.pack.add({ { src = 'https://github.com/nvim-lua/plenary.nvim'} })

vim.keymap.set('n', '<Leader>g', '<cmd>LazyGit<CR>', { desc = 'Open Git UI' } )

-- test auto save
require("visuals")
require("find")
require("language.lua")
require("language.mod")
require("complete")
require("ai")
require("utils")

