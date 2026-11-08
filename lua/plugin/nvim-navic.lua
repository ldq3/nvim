local navic = require("nvim-navic")

navic.setup({
    icons = {
      File = " ",
      Module = " ",
      Class = " ",
      Method = " ",
      Function = " ",
      Variable = " ",
      Constant = " ",
    },
    separator = " > ",
    depth_limit = 4,
    depth_limit_indicator = "…",
})

local lsp_aug = vim.api.nvim_create_augroup("global_lsp_attach", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_aug,
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    navic.attach(client, bufnr)
  end
})

