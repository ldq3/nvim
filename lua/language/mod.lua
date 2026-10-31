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

local navic = require("nvim-navic")
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("global_lsp_attach", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
	local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufopts = { buffer = bufnr }

	navic.attach(client, bufnr)
	vim.api.nvim_create_autocmd({"CursorMoved", "CursorMovedI"}, {
    buffer = bufnr,
    callback = function()
    	local loc = navic.get_location()
    	vim.wo.winbar = loc
    end
  })

    -- LSP快捷键（buffer局部）
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", bufopts, { desc = "LSP: Goto definition(Telescope)" }))
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", bufopts, { desc = "LSP: Goto declaration" }))
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", bufopts, { desc = "LSP: Goto implementation" }))
    vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", bufopts, { desc = "LSP: References" }))
    -- vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", bufopts, { desc = "LSP: Hover doc" }))
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", bufopts, { desc = "LSP: Rename symbol" }))
    vim.keymap.set({"n","v"}, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", bufopts, { desc = "LSP: Code Action" }))

  end
})

require("language.lua")
require("language.haskell")
require("language.obsidian")

