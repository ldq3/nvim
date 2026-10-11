vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true  -- 将 tab 转换为空格
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

require("lualine").setup({
    options = {
        globalstatus = true
    }
})

require("nvim-navic").setup({
})

require('marks').setup {
  -- whether to map keybinds or not. default true
  default_mappings = true,
  -- which builtin marks to show. default {}
  builtin_marks = { ".", "<", ">", "^" },
  -- whether movements cycle back to the beginning/end of buffer. default true
  cyclic = true,
  -- whether the shada file is updated after modifying uppercase marks. default false
  force_write_shada = false,
  -- how often (in ms) to redraw signs/recompute mark positions. 
  -- higher values will have better performance but may cause visual lag, 
  -- while lower values may cause performance penalties. default 150.
  refresh_interval = 250,
  -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
  -- marks, and bookmarks.
  -- can be either a table with all/none of the keys, or a single number, in which case
  -- the priority applies to all marks.
  -- default 10.
  sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
  -- disables mark tracking for specific filetypes. default {}
  excluded_filetypes = {},
  -- disables mark tracking for specific buftypes. default {}
  excluded_buftypes = {},
  -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
  -- sign/virttext. Bookmarks can be used to group together positions and quickly move
  -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
  -- default virt_text is "".
  bookmark_0 = {
    sign = "⚑",
    virt_text = "hello world",
    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
    -- defaults to false.
    annotate = false,
  },
  mappings = {}
}
