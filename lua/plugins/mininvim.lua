vim.pack.add({
	{
		src = "https://github.com/nvim-mini/mini.nvim",
		version = "stable",
	},
})

require("mini.ai").setup({})

-- Surround
require("mini.surround").setup({
	-- Number of lines within which surrounding is searched
	n_lines = 200,
	mappings = {
		add = "ys",
		delete = "ds",
		replace = "cs",
	},
})

-- Remap adding surrounding to Visual mode selection
vim.keymap.del("x", "ys")
vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

-- Make special mapping for "add surrounding for line"
vim.keymap.set("n", "yss", "ys_", { remap = true })

require("mini.pairs").setup({})
require("mini.comment").setup({}) -- improve comments experience
require("mini.trailspace").setup({}) -- show trailspaces
require("mini.notify").setup({}) -- Show notifications in a single floating window
require("mini.icons").setup({}) -- Show appealing icons
