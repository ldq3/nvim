require("avante").setup({
	provider = "openai",
    providers = {
        openai = {
            api_key_name = "DEEPSEEK_AVANTE",
            endpoint = "https://api.deepseek.com/v1",
			model = "deepseek-coder", -- deepseek-chat / deepseek-r1
            max_tokens = 8192,
        },
    },
})

