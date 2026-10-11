
require("obsidian").setup({
    workspaces = {
        { name = "self", path = "/mnt/d/kms/self/" }
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
