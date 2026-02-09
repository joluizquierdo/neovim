return {
    'mbbill/undotree',
    config = function()
        -- Keymaps
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })
    end,
}
