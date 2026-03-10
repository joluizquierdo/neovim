-- color scheme Should be loaded before other plugins
require("plugins.kanagawa")

-- snacks and lazygit
require("plugins.snacks")

-- Show git signs
require("plugins.gitsigns")

-- Collection of +40 plugins to improve nvim experience
-- NOTE: You can select the ones that you want to use...
require("plugins.mininvim")

-- status line with minimal configuration
require("plugins.lualine")

-- Fuzzy find project files
require("plugins.telescope")

-- Bookmark files within a project
require("plugins.harpoon")

-- Manage modification history within a file
require("plugins.undotree")

-- Show a nice menu when pressing leader key
require("plugins.which-key")

-- Make neovim better understand and navigate the code
-- improve folding, indentation and highlight
require("plugins.nvim-treesitter")

-- Language Protocol Server config
require("plugins.nvim-lspconfig")

-- Auto completion
require("plugins.blink-cmp")

-- AI agent integration
require("plugins.opencode")
