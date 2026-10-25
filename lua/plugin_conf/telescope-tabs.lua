require("telescope-tabs").setup({
    entry_formatter = function(tab_id, _, file_names, _, is_current)
        -- 读取 tabflow 的 tabflow_name
        local ok, tab_name = pcall(vim.api.nvim_tabpage_get_var, tab_id, "tabflow_name")
        local label
        if ok and tab_name and tab_name ~= "" then
            label = tab_name
        else
            label = table.concat(file_names, ", ")
        end
        return string.format("%s%s", label, is_current and " <--" or "")
    end,
    show_preview = false,
})

