-- ========== LspAttach 只保留 navic、winbar 逻辑 ==========
local navic = require("nvim-navic")
local lsp_aug = vim.api.nvim_create_augroup("global_lsp_attach", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_aug,
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    navic.attach(client, bufnr)
  end
})

local Navic = {
  condition = function()
    return navic.is_available()
  end,
  provider = function()
    return navic.get_location()
  end,
  hl = "NavicText",
  -- 可选：加左右分隔装饰
  -- surround = { { "" }, { "" }, "WinBar" }
}

local WinBar = {
  fallthrough = false,
  { -- 有navic时显示
    Navic,
  },
  { -- 没有navic时空白/文件名
    provider = function()
      return vim.fn.expand("%:t")
    end,
  }
}

return WinBar

