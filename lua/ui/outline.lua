local M = {}

function M.init(leader)
    vim.keymap.set("n", leader .. "o", "<cmd>Outline<CR>", { desc = "toggle outline" })
end

return M
