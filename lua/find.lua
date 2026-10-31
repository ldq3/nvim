require("which-key").add({{ "<leader>f", group = "Find" }, })


local utils = require("utils.find")
local builtin = require('telescope.builtin')

vim.keymap.set("n", "<leader>fc", builtin.live_grep, { desc = "find file content using regular expression" })
vim.keymap.set('v', '<leader>fc', utils.find_content, { desc = "find file content with selected content" })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "find files with selected content" })
vim.keymap.set("v", "<leader>ff", utils.find_files, { desc = "find files with selected content" })

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
vim.keymap.set("n", "<leader>bx", "<cmd>TabflowCloseTab<CR>", { desc = "close buffer" })
vim.keymap.set("n", "<C-n>", "<cmd>TabflowNextBuffer<CR>", { desc = "close buffer" })
vim.keymap.set("n", "<C-p>", "<cmd>TabflowPrevBuffer<CR>", { desc = "close buffer" })


local api = require("nvim-tree.api")
-- 修改文件后缀名：r
-- 修改文件主体名：e
-- 修改文件路径：<C-r>

vim.keymap.set("n", "<C-y>", api.tree.toggle, { noremap = true, silent = true, desc = "toggle file explorer" })
vim.keymap.set("n", "<leader>fe", function ()
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
end, { noremap = true, silent = true, desc = "find current file in file explorer" })

vim.keymap.set('n', '<Leader>g', '<cmd>LazyGit<CR>', { desc = 'Open Git UI' } )

require("lazygit")
