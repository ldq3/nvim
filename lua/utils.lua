require("setting.nvim-tree")

local api = require("nvim-tree.api")
vim.keymap.set("n", "<C-n>", api.tree.toggle, { noremap = true, silent = true, desc = "NvimTree Toggle" })
vim.keymap.set("n", "<leader>e", api.tree.focus, { noremap = true, silent = true, desc = "NvimTree Focus" })
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
end, { noremap = true, silent = true, desc = "NvimTree 定位当前文件" })
vim.keymap.set("n", "<leader>nc", api.tree.close, { noremap=true, silent=true, desc="NvimTree Close" })

local util = require("lspconfig.util")
require("auto-save").setup({
    -- 核心：每个缓冲区触发保存前执行这个判断
    condition = function(bufnr)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        -- 跳过空文件名、终端、帮助等特殊buffer
        if fname == "" or vim.bo[bufnr].buftype ~= "" then
            return false
        end
        local root = util.root_pattern(unpack({".git"}))(fname)
        return root ~= nil
    end,
})

