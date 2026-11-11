-- https://github.com/neovim/nvim-lspconfig/tree/master/lsp

vim.diagnostic.config({
    virtual_text = false,
    underline = true,
    signs = true,
    update_in_insert = false,
    severity_sort = true,
    virtual_lines = false,
    float = {
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },
})


-- install language server: mason-lspconfig

require("mason-tool-installer").setup({
	ensure_installed = {
	},
})

require("language.lua")
require("language.haskell")
require("language.obsidian")

