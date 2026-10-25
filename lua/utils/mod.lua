local M = {}

function M.try(fn)
  local ok, err = pcall(fn)
  if not ok then
    vim.notify(string.format("[Config Error] %s", err), vim.log.levels.ERROR)
  end
end

return M
