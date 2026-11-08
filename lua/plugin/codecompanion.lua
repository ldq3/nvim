require("codecompanion").setup({
    interactions = {
        chat = {
            adapter = {
                name = "deepseek",
                model = "deepseek-v4-pro",
            },
        },
        inline = {
            adapter = {
                name = "deepseek",
                model = "deepseek-flash",
            },
        },
        cmd = {
          adapter = {
            name = "deepseek",
            model = "deepseek-flash",
          },
        },

        -- 后台任务
        background = {
          adapter = {
            name = "deepseek",
            model = "deepseek-flash",
          },
        },
    },
    opts = {
        log_level = "DEBUG", -- or "TRACE"
    },
    adapters = {
        http = {
            -- deepseek_flash = function()
            --     return require("codecompanion.adapters").extend("deepseek_flash", {
            --         env = {
            --             url = "https://api.deepseek.com/",
            --             api_key = "DEEPSEEK_FLASH_NVIM",
            --             chat_url = "/chat/completions",
            --         },
            --         schema = {
            --             model = {
            --                 default = "deepseek-flash",
            --             },
            --         },
            --     })
            -- end,
        },
    },
})

