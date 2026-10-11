local api = require("nvim-tree.api")

local function move_keep_filename()
    local node = api.tree.get_node_under_cursor()
  if not node or node.type ~= "file" then
    return
  end
  local old_path = node.absolute_path
  local dir = vim.fs.dirname(old_path)
  local fname = vim.fs.basename(old_path)

  local prompt = vim.fn.input("Move to directory: ", dir .. "/")
  if prompt == "" then
    return
  end
  -- 自动创建目标目录
  vim.fn.mkdir(prompt, "p")
  local new_path = prompt .. fname

  -- 使用vim原生文件重命名，绕过nvim-tree api.fs.rename
  local ok, err = vim.uv.fs_rename(old_path, new_path)
  if not ok then
    vim.notify("move failed: " .. (err or ""), vim.log.levels.ERROR)
  end
  api.tree.reload()
end

local function my_on_attach(bufnr)
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- 加载nvim-tree默认快捷键
  api.map.on_attach.default(bufnr)

  -- 新增自定义快捷键 M 触发移动
  vim.keymap.set("n", "M", move_keep_filename, opts("Move file, keep filename"))
end

require("nvim-tree").setup({
	view = {
		number = true,
		relativenumber = true,
	},
    on_attach = my_on_attach,
})
