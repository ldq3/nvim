local M = {}

---@param leader string
---@param key_des table
function M.keymap(leader, key_des)
    for _, item in ipairs(key_des) do
        vim.keymap.set(item[1], leader..item[2], item[3], item[4])
    end
end

return M

