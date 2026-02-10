return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        -- I've only enabled required plugins for
        -- opencode
        input = { enabled = true },
        picker = { enabled = true },
        terminal = { enabled = true },
        lazygit = { enabled = true },

        bigfile = { enabled = false },
        dashboard = { enabled = false },
        explorer = { enabled = false },
        indent = { enabled = false },
        notifier = { enabled = false },
        quickfile = { enabled = false },
        scope = { enabled = false },
        scroll = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
        toggle = { enabled = false },
    },
    config = function(_, opts)
        local snacks = require("snacks")
        snacks.setup(opts)

        -- LazyGit keymap
        vim.keymap.set("n", "<leader>gg", function()
            snacks.lazygit()
        end, { desc = "Open LazyGit" })
    end,
}
