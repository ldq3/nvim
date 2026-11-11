local M = {}

local builtin = require('telescope.builtin')
local api = require("nvim-tree.api")

-- rg正则转义 + 清除换行
local function prepare_visual_text(s)
    -- 把换行全部替换成空格
    s = s:gsub('\n', ' ')
    -- rg特殊字符转义
    s = s:gsub('[%%%*%.%+%-%?%[%]%(%)%{%}\\^%$]', '\\%0')
    return s
end

local function find_content()
    vim.cmd('normal! "vy')
    local selected_text = vim.fn.getreg('v')

    local text = prepare_visual_text(selected_text)
    builtin.live_grep({
        default_text = text
    })
end

local function find_files()
    vim.cmd('normal! "vy')
    local selected_text = vim.fn.getreg('v')

    local text = prepare_visual_text(selected_text)
    builtin.find_files({
        default_text = text,
    })
end

local function file_path ()
    if vim.fn.expand('%') == '' then
        vim.print("no file in the current window")
        return
    end
    -- 如果 tree 没打开，先打开它
    if not api.tree.is_visible() then
        api.tree.open({focus = false})
    end
    -- 定位当前文件到 tree 中
    api.tree.find_file()
end

M.keys = {
    { "n", "c", builtin.live_grep, { desc = "find files content using regular expression" } },
    { "v", "c", find_content, { desc = "find files content with selected content" } },
    { "n", "f", builtin.find_files, { desc = "find files using regular expression" } },
    { "v", "f", find_files, { desc = "find files with selected content" } },
    { "n", "e", file_path, { desc = "find current file in file explorer" }},
}

M.toggle = { api.tree.toggle, { desc = "toggle file explorer" } }

-- 修改文件后缀名：r
-- 修改文件主体名：e
-- 修改文件路径：<C-r>


return M

