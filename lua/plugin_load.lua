--- @param pn string[] list of plugin conf
local function load(pn)
    local dir = "plugin_conf"

    for _, v in ipairs(pn) do
        if vim.uv.fs_stat(vim.fn.stdpath("config") .. '/' .. "lua" .. '/' .. dir .. '/' .. v .. '/' .. "mod.lua") ~= nil then
	        local tmp = dir .. '.' .. v .. '.' .. "mod"
            require(tmp)
        else
            require(dir .. '.' .. v)
        end
    end
end

local plugin_conf = {
    "nvim",
    "auto-save",
    "avante",
    "diffview",

    "tabflow",
    "heirline",

    -- "neo-tree",
    "nvim-tree",
    "outline",
    "overseer",
    "tabflow",

    "telescope",
    "telescope-tabs",

    "trouble",
    "which-key",
    "noice",
}

require("telescope").load_extension("telescope-tabs")

load(plugin_conf)

