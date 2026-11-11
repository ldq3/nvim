-- AstroNvim 风格 statusline（自包含实现，参考 AstroNvim v3 的 heirline 状态栏布局）
--
-- 布局（左 → 右）:
--   ViMode | GitBranch | FileInfo | GitDiff | Diagnostics  ====  CmdInfo  ====  LSP | Treesitter | Nav | ViMode

local utils = require("heirline.utils")

--------------------------------------------------------------------------------
-- helpers
--------------------------------------------------------------------------------

local function escape(str) return str:gsub("%%", "%%%%") end

-- 与 AstroNvim 一致的块分隔符：用空格制造色块之间的间隙，
-- "left" 块左侧无间隙、右侧留 2 格；"right" 块左侧留 2 格、右侧无间隙。
local separators = {
    none = { "", "" },
    left = { "", "  " },
    right = { "  ", "" },
    center = { "  ", "  " },
}

--- 用背景色包裹一个组件，并在两侧加分隔符（等价于 AstroNvim 的 status.utils.surround）。
---@param separator string|string[] "left"/"right"/"none" 或自定义分隔符对
---@param color string|function 色块背景色（颜色名或返回颜色名的函数）
---@param component table 被包裹的组件
---@param condition? function 显示条件
local function surround(separator, color, component, condition)
    local function surround_color(self)
        local c = type(color) == "function" and color(self) or color
        return type(c) == "string" and { main = c } or c
    end
    separator = type(separator) == "string" and separators[separator] or separator
    local surrounded = { condition = condition }
    if separator[1] ~= "" then
        table.insert(surrounded, {
            provider = separator[1],
            hl = function(self)
                local c = surround_color(self)
                if c then return { fg = c.main, bg = c.left } end
            end,
        })
    end
    table.insert(surrounded, {
        hl = function(self)
            local c = surround_color(self)
            if c then return { bg = c.main } end
        end,
        component,
    })
    if separator[2] ~= "" then
        table.insert(surrounded, {
            provider = separator[2],
            hl = function(self)
                local c = surround_color(self)
                if c then return { fg = c.main, bg = c.right } end
            end,
        })
    end
    return surrounded
end

--------------------------------------------------------------------------------
-- conditions
--------------------------------------------------------------------------------

local function is_git_repo()
    return vim.b.gitsigns_head ~= nil or vim.b.gitsigns_status_dict ~= nil
end

local function git_changed()
    local s = vim.b.gitsigns_status_dict
    return s ~= nil and (s.added or 0) + (s.removed or 0) + (s.changed or 0) > 0
end

local function has_diagnostics() return #vim.diagnostic.get(0) > 0 end

local function lsp_attached() return next(vim.lsp.get_clients({ bufnr = 0 })) ~= nil end

local function is_macro_recording() return vim.fn.reg_recording() ~= "" end

local function is_hlsearch() return vim.v.hlsearch ~= 0 end

--------------------------------------------------------------------------------
-- icons
--------------------------------------------------------------------------------

local icons = {
    git_branch = "󰘬",
    git_add = "󰐗",
    git_change = "󰏬",
    git_delete = "󰍷",
    error = "󰅚",
    warn = "󰀪",
    info = "󰋽",
    hint = "󰌵",
    lsp = "",
    macro = "󰽒",
    search = "󰍉",
    scroll = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
}

--------------------------------------------------------------------------------
-- mode
--------------------------------------------------------------------------------

local mode_names = {
    n = "NORMAL",
    i = "INSERT",
    t = "TERM",
    v = "VISUAL",
    V = "LINES",
    ["\22"] = "BLOCK", -- Ctrl-V
    R = "REPLACE",
    s = "SELECT",
    S = "SELECT",
    ["\19"] = "BLOCK", -- Ctrl-S
    c = "COMMAND",
    r = "PROMPT",
    ["!"] = "SHELL",
}

local mode_colors = {
    n = "normal",
    i = "insert",
    t = "terminal",
    v = "visual",
    V = "visual",
    ["\22"] = "visual",
    R = "replace",
    s = "visual",
    S = "visual",
    ["\19"] = "visual",
    c = "command",
    r = "inactive",
    ["!"] = "inactive",
}

---@param side string "left" 或 "right"
local function mode_component(side)
    return surround(side, function() return mode_colors[vim.fn.mode()] or "inactive" end, {
        provider = function()
            local mode = vim.fn.mode()
            return " " .. (mode_names[mode] or mode:upper()) .. " "
        end,
        hl = { fg = "mode_fg", bold = true },
        update = {
            "ModeChanged",
            pattern = "*:*",
            callback = vim.schedule_wrap(function() vim.cmd("redrawstatus") end),
        },
    })
end

--------------------------------------------------------------------------------
-- git
--------------------------------------------------------------------------------

local GitBranch = surround("left", "git_branch_bg", {
    provider = function() return " " .. icons.git_branch .. " " .. (vim.b.gitsigns_head or "") .. " " end,
    hl = { fg = "git_branch_fg", bold = true },
    update = { "User", pattern = "GitSignsUpdate" },
}, is_git_repo)

local function git_sign(icon, key, color)
    return {
        provider = function()
            local s = vim.b.gitsigns_status_dict
            local n = s and s[key] or 0
            return n > 0 and (" " .. icon .. " " .. n .. " ") or ""
        end,
        hl = { fg = color },
    }
end

local GitDiff = surround("left", "git_diff_bg", {
    git_sign(icons.git_add, "added", "git_added"),
    git_sign(icons.git_change, "changed", "git_changed"),
    git_sign(icons.git_delete, "removed", "git_removed"),
}, git_changed)

--------------------------------------------------------------------------------
-- file info
--------------------------------------------------------------------------------


local TabName = {
    provider = function()
        local state = require("tabflow.state")
        local tname = state.state.tabs[vim.api.nvim_get_current_tabpage()].name
        return " "..tname
    end,
    hl = { fg = "file_info_fg" },
}


local TabInfo = surround("left", "file_info_bg", {
    TabName,
})

--------------------------------------------------------------------------------
-- diagnostics
--------------------------------------------------------------------------------

local function diag_sign(icon, severity, color)
    return {
        provider = function()
            local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity[severity] })
            return count > 0 and (" " .. icon .. " " .. count .. " ") or ""
        end,
        hl = { fg = color },
    }
end

local Diagnostics = surround("left", "diagnostics_bg", {
    diag_sign(icons.error, "ERROR", "diag_ERROR"),
    diag_sign(icons.warn, "WARN", "diag_WARN"),
    diag_sign(icons.info, "INFO", "diag_INFO"),
    diag_sign(icons.hint, "HINT", "diag_HINT"),
}, has_diagnostics)

--------------------------------------------------------------------------------
-- cmd info（宏录制 / 搜索计数，通常隐藏）
--------------------------------------------------------------------------------

local CmdInfo = surround("center", "cmd_info_bg", {
    {
        provider = function() return vim.fn.reg_recording() ~= "" and (" " .. icons.macro .. " " .. vim.fn.reg_recording() .. " ") or "" end,
        hl = { fg = "macro_recording_fg", bold = true },
    },
    {
        provider = function()
            if vim.v.hlsearch == 0 then return "" end
            local ok, search = pcall(vim.fn.searchcount)
            if not ok or not search.total or search.total == 0 then return "" end
            return string.format(" %s %d/%d ", icons.search, math.min(search.current, search.maxcount), math.min(search.total, search.maxcount))
        end,
        hl = { fg = "cmd_info_fg" },
    },
}, function() return is_macro_recording() or is_hlsearch() end)

--------------------------------------------------------------------------------
-- lsp
--------------------------------------------------------------------------------

local LSP = surround("right", "lsp_bg", {
    provider = function()
        local names = {}
        for _, client in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
            table.insert(names, client.name)
        end
        table.sort(names)
        return icons.lsp .. " [" .. table.concat(names, ", ") .. "]"
    end,
    hl = { fg = "lsp_fg" },
    update = { "LspAttach", "LspDetach", "BufEnter" },
}, lsp_attached)

--------------------------------------------------------------------------------
-- treesitter
--------------------------------------------------------------------------------

local Treesitter = surround("right", "treesitter_bg", {
    provider = function()
        local ok, parser = pcall(vim.treesitter.get_parser, 0)
        return ok and parser and " TS " or ""
    end,
    hl = { fg = "treesitter_fg" },
}, function()
    local ok, parser = pcall(vim.treesitter.get_parser, 0)
    return ok and parser ~= nil
end)

--------------------------------------------------------------------------------
-- nav（行列位置 / 百分比 / 滚动条）
--------------------------------------------------------------------------------

local Nav = surround("right", "nav_bg", {
    {
        provider = function()
            return string.format(" %3d:%-2d ", vim.fn.line("."), vim.fn.virtcol("."))
        end,
        hl = { fg = "nav_fg" },
    },
    {
        provider = function()
            local current = vim.fn.line(".")
            local total = vim.fn.line("$")
            local pct = total > 0 and math.floor(current * 100 / total) or 0
            return string.format("%3d%% ", pct)
        end,
        hl = { fg = "nav_fg" },
    },
    {
        provider = function()
            local curr = vim.api.nvim_win_get_cursor(0)[1]
            local lines = vim.api.nvim_buf_line_count(0)
            local i = math.floor((curr - 1) / lines * #icons.scroll) + 1
            return icons.scroll[i] and (string.rep(icons.scroll[i], 2) .. " ") or ""
        end,
        hl = { fg = "scrollbar" },
    },
    update = { "CursorMoved", "CursorMovedI", "BufEnter" },
})

--------------------------------------------------------------------------------
-- statusline
--------------------------------------------------------------------------------

local StatusLine = {
    hl = { fg = "fg", bg = "bg" },
    mode_component("left"),
    GitBranch,
    TabInfo,
    GitDiff,
    Diagnostics,
    { provider = "%=" }, -- fill（左侧 / 右侧分界）
    CmdInfo,
    { provider = "%=" },
    LSP,
    Treesitter,
    Nav,
    mode_component("right"),
}

return StatusLine
