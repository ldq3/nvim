require("which-key").add({{ "<leader>f", group = "Find" }, })


local utils = require("utils.find")
local builtin = require('telescope.builtin')


vim.keymap.set("n", "<leader>fc", builtin.live_grep, { desc = "find file content using regular expression" })
vim.keymap.set('v', '<leader>fc', utils.find_content, { desc = "find file content with selected content" })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "find files with selected content" })
vim.keymap.set("v", "<leader>ff", utils.find_files, { desc = "find files with selected content" })

require("outline").setup({
    outline_window = {
        position = "right",
        width = 25,
    },
    symbol_folding = {
        autofold_depth = 1, -- 默认折叠H2以下
        auto_unfold = { hovered = true },
    },
    providers = {
        markdown = {
        -- 识别ATX标题 # ## ###
            show_numbers = true,
        }
    }
})


-- outline
vim.keymap.set("n", "<space>o", "<cmd>Outline<CR>", { desc = "toggle outline" })


local api = require("nvim-tree.api")
-- 修改文件后缀名：r
-- 修改文件主体名：e
-- 修改文件路径：<C-r>

vim.keymap.set("n", "<C-n>", api.tree.toggle, { noremap = true, silent = true, desc = "toggle file explorer" })
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
