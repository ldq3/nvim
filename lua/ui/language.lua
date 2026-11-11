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


M.keys = {
    { "n", "d", defination, { desc = "Definition" } },
    { "n", "D", declaration, { desc = "Declaration" } },
    { "n", "i", implementation, { desc = "Implementation" } },
    { "n", "r", reference, { desc = "References" } },
    { "n", "n", rename_symbol, { desc = "Rename symbol" } },
    { "n", "o", "<cmd>Outline<CR>", { desc = "toggle outline" } },
    { "n", "H", vim.diagnostic.open_float, { desc = "Open diagnostic float" } },
    { "n", "a", code_action, { desc = "Code Action" } },
}

return M
