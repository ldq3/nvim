-- <leader>b
local M = {}

M.keys = {
    {"n", "x", "<cmd>TabflowCloseBuffer<CR>", { desc = "close buffer" }},
}

M.next = { "<cmd>TabflowNextBuffer<CR>", { desc = "next buffer" }}
M.prev = { "<cmd>TabflowPrevBuffer<CR>", { desc = "prev buffer" }}

return M

