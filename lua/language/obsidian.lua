local info = require("info")

require("obsidian").setup({
    workspaces = {
        info.ob_workspace
    },
    picker = {
        name = "telescope.nvim",
        note_mappings = {
            new = "<C-x>",
            insert_link = "<C-l>",
            bookmark = "<C-b>",
        },
        tag_mappings = {
            tag_note = "<C-x>",
            insert_tag = "<C-l>",
        },
    }
})
