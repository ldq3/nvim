vim.pack.add({
     "https://github.com/hrsh7th/nvim-cmp",
     "https://github.com/hrsh7th/cmp-nvim-lsp",
     "https://github.com/hrsh7th/cmp-buffer",
     "https://github.com/hrsh7th/cmp-path",
     "https://github.com/hrsh7th/cmp-cmdline",
     "https://github.com/L3MON4D3/LuaSnip",
     "https://github.com/saadparwaiz1/cmp_luasnip",
     "https://github.com/rafamadriz/friendly-snippets",
})

Cmp = require("cmp")
Luasnip = require("luasnip")

Cmp.setup({
    -- 代码片段
    snippet = {
        expand = function(args)
            Luasnip.lsp_expand(args.body)
        end,
    },

    -- 补全菜单外观
    window = {
        completion = Cmp.config.window.bordered(),
        documentation = Cmp.config.window.bordered(),
    },

	formatting = {
		format = function(entry, vim_item)
			local source_map = {
	    		nvim_lsp = "[LSP]",
				luasnip = "[Snip]",
				buffer = "[BUF]",
				path = "[PATH]",
				nvim_lua = "[LuaAPI]",
			}
			vim_item.menu = source_map[entry.source.name] or ("["..entry.source.name.."]")
			-- 安全访问，逐层判空
			local src = entry.source
			if src.name == "nvim_lsp" and src.source and src.source.client then
				vim_item.menu = vim_item.menu.."("..src.source.client.name..")"
			end

			return vim_item
		end

	},

    -- 补全源及优先级
    sources = Cmp.config.sources({
        { name = "nvim_lsp" },   -- LSP（最高优先级）
        { name = "luasnip" },     -- 代码片段
        { name = "buffer" },      -- 缓冲区词汇
        { name = "path" },        -- 文件路径
		{ name= "lazydev" },
    }),

    -- 命令行补全（: 命令模式）
    Cmp.setup.cmdline(":", {
        mapping = Cmp.mapping.preset.cmdline(),
        sources = Cmp.config.sources({
            { name = "path" },
        }, {
            { name = "cmdline" },
        }),
    })
})
