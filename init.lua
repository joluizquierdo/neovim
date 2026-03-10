-- load core config
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Ensure the Neovim cache directory exists before plugins
local cache_dir = vim.fn.stdpath("cache")
if vim.fn.isdirectory(cache_dir) == 0 then
    vim.fn.mkdir(cache_dir, "p")
end

-- Plugins
require("plugins")
