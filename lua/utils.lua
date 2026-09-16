vim.keymap.set("n", "<leader>gf", function()
  local word = vim.fn.expand("<cword>")
  require("telescope.builtin").find_files({
    default_text = word,
  })
end, {desc = "Telescope find files with cursor word"})

require("setting.nvim-tree")

local api = require("nvim-tree.api")
vim.keymap.set("n", "<C-n>", api.tree.toggle, { noremap = true, silent = true, desc = "NvimTree Toggle" })
vim.keymap.set("n", "<leader>e", api.tree.focus, { noremap = true, silent = true, desc = "NvimTree Focus" })
vim.keymap.set("n", "<leader>fe", api.tree.find_file, { noremap = true, silent = true, desc = "NvimTree 定位当前文件" })
vim.keymap.set("n", "<leader>nc", api.tree.close, { noremap=true, silent=true, desc="NvimTree Close" })

