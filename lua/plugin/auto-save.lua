local util = require("lspconfig.util")

require("auto-save").setup({
    -- 核心：每个缓冲区触发保存前执行这个判断
    condition = function(bufnr)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        -- 跳过空文件名、终端、帮助等特殊buffer
        if fname == "" or vim.bo[bufnr].buftype ~= "" then
            return false
        end
        local root = util.root_pattern(unpack({".git", ".obsidian"}))(fname)
        return root ~= nil
    end,
})
