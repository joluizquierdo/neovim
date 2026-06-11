vim.pack.add({
	-- Dependencies
	"https://github.com/nvim-tree/nvim-web-devicons",
	-- Plugin
	"https://github.com/nvim-lualine/lualine.nvim",
})

require("lualine").setup({
	sections = {
		lualine_z = {
			{
				require("opencode").statusline,
			},
		},
	},
})
