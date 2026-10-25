---@diagnostic disable-next-line: duplicate-set-field
    require("tabflow.util").git_branch = function()
    return nil
end

require("tabflow").setup({
    commands = {
        "TabflowNewTab", "TabflowRenameTab", "TabflowCloseTab",
        "TabflowCloseBuffer", "TabflowNextBuffer", "TabflowPrevBuffer",
    },
})

