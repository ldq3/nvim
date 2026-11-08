
vim.keymap.set("n", "<leader>tl", "<cmd>Telescope telescope-tabs list_tabs<CR>", { desc = "open tab list" })
vim.keymap.set("n", "<leader>tc", "<cmd>TabflowNewTab<CR>", { desc = "create tab" })
vim.keymap.set("n", "<leader>tn", function()
  vim.ui.input({ prompt = "Name：", default = "" }, function(arg)
    if arg then -- 用户没有按Esc取消
      vim.cmd("TabflowRenameTab " .. arg)
    end
  end)
end, { desc = "tab name" })
vim.keymap.set("n", "<leader>tx", "<cmd>TabflowCloseTab<CR>", { desc = "close tab" })
