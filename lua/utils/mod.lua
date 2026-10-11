local M = {}

function M.try(fn)
  local ok, err = pcall(fn)
  if not ok then
    vim.notify(string.format("[Config Error] %s", err), vim.log.levels.ERROR)
  end
end

function M.load_all_modules(module_dir)
  local dir_path = module_dir:gsub("%.", "/")
  local files = vim.api.nvim_get_runtime_file("lua/" .. dir_path .. "/*.lua", true)
  for _, filepath in ipairs(files) do
    local mod_name = filepath:match(".*/(.*)%.lua$")
    if mod_name then
      local full_mod = module_dir .. "." .. mod_name
      require(full_mod)
    end
  end
end


return M
