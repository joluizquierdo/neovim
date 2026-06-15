vim.pack.add({
	-- dependencies
	"https://github.com/folke/snacks.nvim", -- format the code
	-- plugin
	"https://github.com/nickjvandyke/opencode.nvim",
})

vim.g.opencode_opts = {}

-- Required for `opts.events.reload`.
vim.o.autoread = true

-- OpenCode keymaps - consistent <leader>o prefix
vim.keymap.set({ "n", "x" }, "<leader>oa", function()
	require("opencode").ask("@this: ", { submit = true })
end, { desc = "Ask opencode…" })
vim.keymap.set({ "n", "x" }, "<leader>om", function()
	require("opencode").select()
end, { desc = "Execute opencode action…" })

vim.keymap.set({ "n", "x" }, "<leader>or", function()
	return require("opencode").operator("@this ")
end, { desc = "Add range to opencode", expr = true })
vim.keymap.set("n", "<leader>ol", function()
	return require("opencode").operator("@this ") .. "_"
end, { desc = "Add line to opencode", expr = true })

vim.keymap.set("n", "<leader>ou", function()
	require("opencode").command("session.half.page.up")
end, { desc = "Scroll opencode up" })
vim.keymap.set("n", "<leader>od", function()
	require("opencode").command("session.half.page.down")
end, { desc = "Scroll opencode down" })

-- Add a convenient keymap to interrupt OpenCode from normal mode
vim.keymap.set("n", "<leader>oi", function()
	require("opencode").command("session.interrupt")
end, { desc = "Interrupt opencode session" })

-- Cycle between agents
vim.keymap.set("n", "<leader>oc", function()
	require("opencode").command("agent.cycle")
end, { desc = "Cycle opencode agent forward" })
vim.keymap.set("n", "<leader>oC", function()
	require("opencode").command("agent.cycle.reverse")
end, { desc = "Cycle opencode agent backward" })

-- Session management
vim.keymap.set("n", "<leader>oss", function()
	require("opencode").command("session.list")
end, { desc = "List opencode sessions" })
vim.keymap.set("n", "<leader>osn", function()
	require("opencode").command("session.new")
end, { desc = "Create new opencode session" })
vim.keymap.set("n", "<leader>osu", function()
	require("opencode").command("session.undo")
end, { desc = "Undo opencode session changes" })
vim.keymap.set("n", "<leader>osr", function()
	require("opencode").command("session.redo")
end, { desc = "Redo opencode session changes" })
