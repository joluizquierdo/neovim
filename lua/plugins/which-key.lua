vim.pack.add({
    'https://github.com/folke/which-key.nvim'
})

-- 2. Pass your 'opts' directly into the setup function
require("which-key").setup({
    spec = {
        { "<leader>c", group = "code" },
        { "<leader>h", group = "harpoon" },
        { "<leader>g", group = "git" },
        { "<leader>o", group = "opencode" },
        { "<leader>p", group = "project" },
        { "<leader>q", group = "quit" },
        { "<leader>b", group = "buffer" },
        { "<leader>t", group = "toggle" },
        { "<leader>d", group = "diagnostics" },
        { "<leader>l", group = "LSP" },
    },
    icons = {
        mappings = false,
    },
})

-- 3. Define your 'keys' explicitly using Neovim's keymap API
vim.keymap.set("n", "<leader>?", function()
    require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })

