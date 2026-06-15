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
	mappings = {
		add = "ys",
		delete = "ds",
		replace = "cs",
		find = "sf",
		find_left = "sF",
		highlight = "sh", -- Highlight surrounding
	},
	highlight_duration = 1000,
	n_lines = 10,
	search_method = "cover_or_nearest",
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
