require("which-key").add({
  { "<leader>f", group = "Find" },
  { "<leader>fg", desc = "Grep string / selected text" },
})

local builtin = require("telescope.builtin")

-- 普通模式：搜索光标下单词
vim.keymap.set("n", "<leader>fg", function()
  builtin.grep_string()
end, { desc = "Telescope: grep word under cursor" })

-- 可视模式：搜索选中字符串
vim.keymap.set("v", "<leader>fg", function()
  -- 复制选中内容到无名寄存器
  vim.cmd.normal('"fy')
  local sel = vim.fn.getreg('"f')
  -- 去掉换行符（多行选中会带\n，rg会匹配换行）
  sel = sel:gsub("\n", " ")
  builtin.grep_string({ search = sel })
end, { desc = "grep visual selection" })

vim.keymap.set("n", "<leader>ff", function()
  local word = vim.fn.expand("<cword>")
  require("telescope.builtin").find_files({
    default_text = word,
  })
end, {desc = "Telescope find files with cursor word"})

