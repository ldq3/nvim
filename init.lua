vim.pack.add({
    { src = "https://github.com/sphamba/smear-cursor.nvim", placement = "start"},
	{ src = "https://github.com/nvim-lua/plenary.nvim", load = true },
    { src = "https://github.com/nvim-telescope/telescope.nvim", load = true },
	"https://github.com/catppuccin/nvim.git",
})

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.winborder = "rounded"

require("smear_cursor").setup({
    cursor_color = "#9932CC",
    particles_enalble = true,
    particles_max_num = 200,
    stiffness = 0.5,
    trailing_stiffness = 0.2,
    trailing_exponent = 5,
    damping = 0.6,
    gadient_exponent = 0,
})

require("catppuccin").setup({
    flavour = "mocha", -- mocha(最深) / macchiato / frappe / latte(浅色)
    transparent_background = false, -- 关闭透明背景
    integrations = {
      nvimtree = true,
      telescope = true,
      cmp = true,
    },
	custom_highlights = function(colors)
    return {
      -- 普通行号：调亮
      LineNr = { fg = colors.overlay2 },
      -- 当前光标行号：高亮加粗
      CursorLineNr = { fg = colors.peach, bold = true },
      -- 侧边符号列(git/lsp)同步颜色，消除色差
      SignColumn = { fg = colors.overlay2 },
    }
  end,
})

vim.cmd.colorscheme("catppuccin")

require("language.mod")
require("complete")
require("ai")
