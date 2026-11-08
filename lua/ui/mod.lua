-- normal
-- q: 开始录制宏
-- Q: 
-- w: 

require("ui.language").set_leader("<leader>l")
require("ui.file").set_leader("<leader>f")
require("ui.buffer")
require("ui.complete")
require("ui.tab")

local wk = require("which-key")
wk.add({
    { "<leader>l", group = "language" },
    { "<leader>b", group = "Buffer" },
    { "<leader>f", group = "File" },
    { "<leader>t", group = "Tab" },
})
-- set

vim.keymap.set("n", "<space>t", "<cmd>TodoTrouble<cr>", { desc = "Open todo list" })
vim.keymap.set("n", "<leader>m", "<cmd>Noice<cr>", { desc = "Open message" })
vim.keymap.set('n', '<Leader>g', '<cmd>LazyGit<CR>', { desc = 'Open Git UI' } )
local lib = require("ui.lib")

lib.keymap("<leader>x", "n", {
    {
      "x",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "s",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "l",
      "<cmd>Trouble lsp toggle focus=false<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "L",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "Q",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
})
