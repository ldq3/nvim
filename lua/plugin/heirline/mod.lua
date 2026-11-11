local utils = require("heirline.utils")

local function get_hl(name)
    local ok, val = pcall(utils.get_highlight, name)
    if ok and type(val) == "table" then return val end
    return {}
end

local function fg(name, fallback)
    return get_hl(name).fg or fallback
end

--- 构建 AstroNvim 风格的语义色表（参考 AstroNvim v3 的 setup_colors），
--- 同时保留 buffer.lua / winbar.lua 依赖的旧颜色名。
local function setup_colors()
    local statusline = get_hl("StatusLine")
    local folded = get_hl("Folded")
    local diff_delete = get_hl("DiffDelete")

    local colors = {
        -- 基础
        fg = statusline.fg or "#cdd6f4",
        bg = statusline.bg or "#11111b",
        section_fg = statusline.fg or "#cdd6f4",
        section_bg = statusline.bg or "#11111b",
        mode_fg = statusline.bg or "#11111b",

        -- 模式色（块背景）
        normal = fg("Function", "#89b4fa"),
        insert = fg("String", "#a6e3a1"),
        visual = fg("Statement", "#cba6f7"),
        replace = fg("DiagnosticError", "#f38ba8"),
        command = fg("Constant", "#fab387"),
        terminal = fg("String", "#a6e3a1"),
        inactive = fg("NonText", "#585b70"),

        -- git
        git_branch_fg = fg("Conditional", "#cba6f7"),
        git_added = fg("GitSignsAdd", "#a6e3a1"),
        git_changed = fg("GitSignsChange", "#fab387"),
        git_removed = fg("GitSignsDelete", "#f38ba8"),

        -- 诊断
        diag_ERROR = fg("DiagnosticError", "#f38ba8"),
        diag_WARN = fg("DiagnosticWarn", "#fab387"),
        diag_INFO = fg("DiagnosticInfo", "#89b4fa"),
        diag_HINT = fg("DiagnosticHint", "#f9e2af"),

        -- 其他
        lsp_fg = fg("Function", "#89b4fa"),
        treesitter_fg = fg("String", "#a6e3a1"),
        scrollbar = fg("TypeDef", "#fab387"),

        -- 兼容 buffer.lua / winbar.lua 的旧颜色名
        bright_bg = folded.bg,
        bright_fg = folded.fg,
        red = fg("DiagnosticError", "#f38ba8"),
        dark_red = diff_delete.bg,
        green = fg("String", "#a6e3a1"),
        blue = fg("Function", "#89b4fa"),
        gray = fg("NonText", "#585b70"),
        orange = fg("Constant", "#fab387"),
        purple = fg("Statement", "#cba6f7"),
        cyan = fg("Special", "#94e2d5"),
        diag_warn = fg("DiagnosticWarn", "#fab387"),
        diag_error = fg("DiagnosticError", "#f38ba8"),
        diag_hint = fg("DiagnosticHint", "#f9e2af"),
        diag_info = fg("DiagnosticInfo", "#89b4fa"),
        git_del = fg("diffDeleted", "#f38ba8"),
        git_add = fg("diffAdded", "#a6e3a1"),
        git_change = fg("diffChanged", "#fab387"),
    }

    -- 未显式指定的 section 背景/前景色回退到 section_bg / section_fg
    for _, section in ipairs {
        "git_branch", "file_info", "git_diff", "diagnostics",
        "lsp", "macro_recording", "cmd_info", "treesitter", "nav", "mode",
    } do
        if not colors[section .. "_bg"] then colors[section .. "_bg"] = colors.section_bg end
        if not colors[section .. "_fg"] then colors[section .. "_fg"] = colors.section_fg end
    end

    return colors
end

local function load_colors()
    require("heirline").load_colors(setup_colors())
end

-- 先立即取色兜底（避免颜色名未定义报错），此时可能是默认主题色
load_colors()
require("heirline").setup({
    tabline = require("plugin.heirline.buffer"),
    statusline = require("plugin.heirline.status"),
    winbar = require("plugin.heirline.winbar"),
})

-- 配色方案在本模块之后才加载（init.lua 中 visuals 靠后），延迟重新取色
vim.schedule(load_colors)

-- 切换配色方案后刷新颜色，并清空缓存强制重渲染
local augroup = vim.api.nvim_create_augroup("HeirlineColors", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
    group = augroup,
    desc = "Refresh heirline colors",
    callback = function()
        vim.schedule(function()
            load_colors()
            local heirline = require("heirline")
            for _, bar in ipairs { heirline.statusline, heirline.winbar, heirline.tabline } do
                if bar then
                    bar:broadcast(function(c) c._win_cache = nil end)
                end
            end
            vim.cmd("redrawstatus")
        end)
    end,
})
