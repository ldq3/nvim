-- normal
-- q: 开始录制宏
-- Q: 
-- w: 

local function set_leader(modules)
    local wk = require("which-key")

    for _, entry in ipairs(modules) do
        local name, leader = entry[1], entry[2]
        local mod = require("ui." .. name)
        if next(mod) ~= nil then
            require("ui.lib").keymap(leader, mod.keys)
        end
        wk.add({{ leader, group = name },})
    end
end

local function set_key(modules)
    for _, entry in ipairs(modules) do
        local name, data, mode, key = entry[1], entry[2], entry[3], entry[4]
        local mod = require("ui." .. name)
        if next(mod) ~= nil then
            f, opt = unpack(mod[data])
            vim.keymap.set(mode, key, f, opt)
        end
    end
end


set_leader({
    { "buffer", "<leader>b" },
    { "complete", "<leader>c" },
    { "file", "<leader>f" },
    { "language", "<leader>l" },
    { "tab", "<leader>t" },
})

set_key({
    { "file", "toggle", "n", "<C-y>" },
    { "buffer", "prev", "n", "<C-p>" },
    { "buffer", "next", "n", "<C-n>" },
})


vim.keymap.set("n", "<space>t", "<cmd>TodoTrouble<cr>", { desc = "Open todo list" })
vim.keymap.set("n", "<leader>m", "<cmd>Noice<cr>", { desc = "Open message" })
vim.keymap.set('n', '<Leader>g', '<cmd>LazyGit<CR>', { desc = 'Open Git UI' } )
local lib = require("ui.lib")

lib.keymap("<leader>x", {
    {
        "n",
        "x",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
    },
    {
        "n",
        "s",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
    },
    {
        "n",
        "l",
        "<cmd>Trouble lsp toggle focus=false<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
        "n",
        "L",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
    },
    {
        "n",
        "Q",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
    },
})
