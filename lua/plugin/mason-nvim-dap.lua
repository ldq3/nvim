-- dependency: mason, nvim-dap
require("mason-nvim-dap").setup({
    ensure_installed = {
        "debugpy",
    },
    automatic_installation = true,
})

