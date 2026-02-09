return {
    -- This plugin is the colorscheme
    'rebelot/kanagawa.nvim',
    priority = 1000, -- Load before other plugins
    config = function()
        require('kanagawa').setup({}) -- default settings
        vim.cmd('colorscheme kanagawa')
    end,

}
