-- Plugin Installation
vim.pack.add({
    {
        src = "https://github.com/nvim-mini/mini.nvim",
        version = "stable",
    }
})

-- Enable plugins

require('mini.ai').setup({})
require('mini.surround').setup({
    -- Number of lines within which surrounding is searched
    n_lines = 200,
})
require('mini.pairs').setup({})
require('mini.comment').setup({}) -- improve comments experience
require('mini.trailspace').setup({}) -- show trailspaces
require('mini.notify').setup({}) -- Show notifications in a single floating window
require('mini.icons').setup({}) -- Show appealing icons
