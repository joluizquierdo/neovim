vim.pack.add({ "https://github.com/folke/snacks.nvim" })

local snacks = require("snacks")
snacks.setup({
	-- I've only enabled required plugins for opencode
	-- and lazygit
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
})

vim.keymap.set("n", "<leader>gg", function()
	snacks.lazygit()
end, { desc = "Open LazyGit" })
