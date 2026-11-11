local M = {}

local function rename()
  vim.ui.input({ prompt = "Name：", default = "" }, function(arg)
    if arg then -- 用户没有按Esc取消
      vim.cmd("TabflowRenameTab " .. arg)
    end
  end)
end

M.keys = {
    { "n", "l", "<cmd>Telescope telescope-tabs list_tabs<CR>", { desc = "open tab list" } },
    { "n", "c", "<cmd>TabflowNewTab<CR>", { desc = "create tab" } },
    { "n", "n", rename, { desc = "tab name" } },
    { "n", "x", "<cmd>TabflowCloseTab<CR>", { desc = "close tab" } },
}

return M

