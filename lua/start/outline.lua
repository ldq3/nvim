require("outline").setup({
    outline_window = {
        position = "right",
        width = 25,
    },
    symbol_folding = {
        autofold_depth = 1, -- 默认折叠H2以下
        auto_unfold = { hovered = true },
    },
    providers = {
        markdown = {
        -- 识别ATX标题 # ## ###
            show_numbers = true,
        }
    }
})

