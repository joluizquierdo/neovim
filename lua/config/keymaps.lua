-- Open FileTree in normal mode with a shortcut instead of :Ex
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Quit all windows
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

