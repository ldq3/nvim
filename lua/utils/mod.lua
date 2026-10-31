local M = {}

function M.try(fn)
  local ok, err = pcall(fn)
  if not ok then
    vim.notify(string.format("[Config Error] %s", err), vim.log.levels.ERROR)
  end
end


---@param mode string
---@param key_des table
function M.keymap(mode, key_des)
    for _, item in ipairs(key_des) do
        vim.keymap.set(mode, item[1], item[2], item[3])
    end
end

return M
