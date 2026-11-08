--- @param pn string[] list of plugin conf
local function load(pn)
    local mod = "plugin"
    local dir = vim.fn.stdpath("config") .. '/' .. "lua" .. '/' .. mod

    for _, v in ipairs(pn) do
        if vim.uv.fs_stat(dir .. '/' .. v .. '/' .. "mod.lua") ~= nil then
	        local tmp = mod .. '.' .. v .. '.' .. "mod"
            require(tmp)
        else
            require(mod .. '.' .. v)
        end
    end
end

local conf = {
    "nvim",
    -- "nvim-cmp",
    "auto-save",
    "diffview",

    "tabflow",
    "heirline",

    "nvim-tree",
    "outline",
    "overseer",
    "tabflow",

    "telescope",
    "telescope-tabs",

    "trouble",
    "which-key",
    "noice",
    "edgy",
    "todo-comments",
    "nvim-dap",
    "mason",
    "mason-lspconfig",
    "mason-nvim-dap",
    "nvim-navic",
    "codecompanion",
    "blink",
}

require("lazygit")

require("telescope").load_extension("telescope-tabs")

load(conf)

