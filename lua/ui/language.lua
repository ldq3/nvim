local M = {}

local utils = require("ui.lib")

local function has_lsp()
  return #vim.lsp.get_clients({bufnr = 0}) > 0
end

local function defination()
  if not has_lsp() then return end
  vim.lsp.buf.definition()
end
local function declaration()
  if not has_lsp() then return end
  vim.lsp.buf.declaration()
end
local function implementation()
  if not has_lsp() then return end
  vim.lsp.buf.implementation()
end
local function reference()
  if not has_lsp() then return end
  vim.lsp.buf.references()
end
local function rename_symbol()
  if not has_lsp() then return end
  vim.lsp.buf.rename()
end
local function code_action()
  if not has_lsp() then return end
  vim.lsp.buf.code_action()
end

-- K: vim.lsp.buf.hove

function M.set_leader(leader)
    local opts = { noremap = true, silent = true }

    utils.keymap(leader, "n", {
        { "a", code_action, vim.tbl_extend("force", opts, { desc = "Code Action" }) },
        { "d", defination, vim.tbl_extend("force", opts, { desc = "Definition" }) },
        { "D", declaration, vim.tbl_extend("force", opts, { desc = "Declaration" }) },
        { "i", implementation, vim.tbl_extend("force", opts, { desc = "Implementation" }) },
        { "r", reference, vim.tbl_extend("force", opts, { desc = "References" }) },
        { "n", rename_symbol, vim.tbl_extend("force", opts, { desc = "Rename symbol" }) },
        { "o", "<cmd>Outline<CR>", { desc = "toggle outline" } },
        { "H", vim.diagnostic.open_float, {desc = "Open diagnostic float" }},
    })

    utils.keymap(leader, "n", {
        { "a", code_action, vim.tbl_extend("force", opts, { desc = "Code Action" }) },
    })
end

return M
