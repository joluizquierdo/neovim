return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        spec = {
            { "<leader>c", group = "code" },
            { "<leader>h", group = "harpoon" },
            { "<leader>g", group = "git" },
            { "<leader>o", group = "opencode" },
            { "<leader>p", group = "project" },
            { "<leader>q", group = "quit" },
            { "<leader>b", group = "buffer" },
            { "<leader>t", group = "toggle" },
        },
        icons = {
            mappings = false,
        },
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
