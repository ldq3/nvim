vim.opt.conceallevel = 1
vim.opt.concealcursor = "n"
vim.opt.laststatus = 3
vim.opt.splitkeep = "screen"

vim.diagnostic.config({
    update_in_insert = false
})

vim.g.lean_config = { mappings = true }  -- from: lean
vim.g.barbar_auto_setup = false
