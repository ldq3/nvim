require("edgy").setup({
    left = {
        {
            title = "File",
            ft = "NvimTree",
        },
        {
            title = function()
                local buf_name = vim.api.nvim_buf_get_name(0) or "[No Name]"
                return vim.fn.fnamemodify(buf_name, ":t")
            end,
            ft = "Outline",
            -- pinned = true,
        }
    },
    right = {
        {
            ft = "codecompanion",
            title = "Chat",
            size = { width = 48 },
            -- 过滤：只捕获普通split，排除浮动窗口
            filter = function(_, winid)
              return vim.api.nvim_win_get_config(winid).relative == ""
            end,
        },
    },
    bottom = {
      {
        title = "Msg",
        ft = "noice",
        size = { height = 0.3 },
        -- 关键 filter：只抓普通 split 窗口，排除 floating popup
        filter = function(buf, win)
          return vim.api.nvim_win_get_config(win).relative == ""
        end,
      },
    },
})

