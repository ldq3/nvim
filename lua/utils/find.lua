local M = {}

local builtin = require('telescope.builtin')

-- rg正则转义 + 清除换行
local function prepare_visual_text(s)
    -- 把换行全部替换成空格
    s = s:gsub('\n', ' ')
    -- rg特殊字符转义
    s = s:gsub('[%%%*%.%+%-%?%[%]%(%)%{%}\\^%$]', '\\%0')
    return s
end

function M.find_content()
    vim.cmd('normal! "vy')
    local selected_text = vim.fn.getreg('v')

    local text = prepare_visual_text(selected_text)
    builtin.live_grep({
        default_text = text
    })
end

function M.find_files()
    vim.cmd('normal! "vy')
    local selected_text = vim.fn.getreg('v')

    local text = prepare_visual_text(selected_text)
    builtin.find_files({
        default_text = text,
    })
end

return M
