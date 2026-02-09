-- Make sure to setup `mapleader` and `maplocalleader` before
-- load core config
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- load core config
require("config.options")
require("config.keymaps")

-- load lazy package manager
require("config.lazy")
