local utils = require("heirline.utils")

local TablineFileName = {
    provider = function(self)
        local filename = self.filename
        filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
        return filename
    end,

    hl = function(self)
        return { bold = self.is_active or self.is_visible, italic = true }
    end,
}

local TablineFileFlags = {
    {
        condition = function(self)
            return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
        end,

        provider = "[+]",

        hl = { fg = "green" },
vim.keymap.set("n", "<leader>bx", "<cmd>TabflowCloseTab<CR>", { desc = "close buffer" })
    },
    {
        condition = function(self)
            return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
            or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
        end,

        provider = function(self)
            if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
                return "  "
            else
                return ""
            end
        end,

        hl = { fg = "orange" },
    },
}

local FileIcon = {
    init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
    return self.icon and (self.icon .. " ")
    end,
    hl = function(self)
    return { fg = self.icon_color }
    end
}

local TablineFileNameBlock = {
    init = function(self)
    self.filename = vim.api.nvim_buf_get_name(self.bufnr)
    end,
    hl = function(self)
    if self.is_active then
    return "TabLineSel"
    -- why not?
    -- elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
    --     return { fg = "gray" }
    else
    return "TabLine"
    end
    end,
    on_click = {
    callback = function(_, minwid, _, button)
    if (button == "m") then -- close on mouse middle click
    vim.schedule(function()
    vim.api.nvim_buf_delete(minwid, { force = false })
    end)
    else
    vim.api.nvim_win_set_buf(0, minwid)
    end
    end,
    minwid = function(self)
    return self.bufnr
    end,
    name = "heirline_tabline_buffer_callback",
    },
    FileIcon, -- turns out the version defined in #crash-course-part-ii-filename-and-friends can be reutilized as is here!
    TablineFileName,
    TablineFileFlags,
}

local TablineCloseButton = {
    condition = function(self)
        return not vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
    end,
    { provider = " " },
    {
        provider = "×",
        hl = { fg = "gray" },
        on_click = {
            callback = function(_, minwid)
            vim.schedule(function()
            vim.api.nvim_buf_delete(minwid, { force = false })
            vim.cmd.redrawtabline()
            end)
            end,
            minwid = function(self)
            return self.bufnr
            end,
            name = "heirline_tabline_close_buffer_callback",
        },
    },
}

local TablineBufferBlock = utils.surround(
    { "", "" },
    function(self)
        if self.is_active then
            return utils.get_highlight("TabLineSel").bg
        else
            return utils.get_highlight("TabLine").bg
        end
    end,
    { TablineFileNameBlock, TablineCloseButton }
)

local state = require("tabflow.state")
local buffers = {}
vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete", "TabEnter" }, {
    callback = function ()
        vim.schedule(function()
            local tmp = state.state.tabs[vim.api.nvim_get_current_tabpage()].buffers
            for i, v in ipairs(tmp) do
                buffers[i] = v
            end
            for i = #tmp + 1, #buffers do
                buffers[i] = nil
            end
            vim.cmd.redrawtabline()
        end)
    end
})

BufferLine = utils.make_buflist(
    TablineBufferBlock,
    { provider = "", hl = { fg = "gray" } }, -- left truncation, optional (defaults to "<")
    { provider = "", hl = { fg = "gray" } }, -- right trunctation, also optional (defaults to ...... yep, ">")
    function ()
        return buffers
    end,
    false
)

return BufferLine
