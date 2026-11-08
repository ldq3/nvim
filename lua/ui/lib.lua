local M = {}

---@param leader string
---@param mode string
---@param key_des table
function M.keymap(leader, mode, key_des)
    for _, item in ipairs(key_des) do
        vim.keymap.set(mode, leader..item[1], item[2], item[3])
    end
end

return M

