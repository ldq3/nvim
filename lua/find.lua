require("which-key").add({
  { "<leader>f", group = "Find" },
})

local builtin = require('telescope.builtin')

-- rg正则转义 + 清除换行
local function prepare_visual_text(s)
    -- 把换行全部替换成空格
    s = s:gsub('\n', ' ')
    -- rg特殊字符转义
    s = s:gsub('[%%%*%.%+%-%?%[%]%(%)%{%}\\^%$]', '\\%0')
    return s
end

-- 可视模式映射
vim.keymap.set('v', '<leader>fg', function()
  vim.cmd('normal! "vy')
  local selected_text = vim.fn.getreg('v')

    local text = prepare_visual_text(selected_text)
    builtin.live_grep({
    default_text = text
  })
end, { desc = "Telescope LiveGrep visual selection (no newline)" })

-- 普通模式
vim.keymap.set("n", "<leader>fg", function()
  builtin.live_grep()
end, { desc = "Telescope: live grep empty prompt" })

vim.keymap.set("n", "<leader>ff", function()
  local word = vim.fn.expand("<cword>")
  require("telescope.builtin").find_files({
    default_text = word,
  })
end, {desc = "Telescope find files with cursor word"})

