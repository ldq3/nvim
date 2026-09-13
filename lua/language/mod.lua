vim.pack.add({
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/williamboman/mason-lspconfig.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
})

vim.diagnostic.config({
  virtual_text = { prefix = "●" },
  underline = true,
  signs = true,
  update_in_insert = false,
})

require("mason").setup({})  -- /home/cipher/.local/share/nvim/site/pack/core/opt/mason.nvim
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",   -- ✅这里才是放lua语言服务器
        "pyright",
		"rust_analyzer",
		"ts_ls",
    },
    automatic_enable = true,
})

require("nvim-treesitter.config").setup({
    auto_install = true,
	install_dir = vim.fn.stdpath('data') .. '/site',
    ensure_installed = { "lua", "python", "typescript", "rust" },
    highlight = {
        enable = true,
        additional_vim_regx_highlighting = false,
    },
})

require("language.lua")
require("language.python")
