return {
    -- This plugin is the colorscheme
    'rebelot/kanagawa.nvim',
    priority = 1001, -- Load before other plugins
    config = function()
        require('kanagawa').setup({}) -- default settings
        vim.cmd('colorscheme kanagawa')

        -- Override spell highlighting for better visibility
        -- Uses underline + color which works in most terminals
        vim.api.nvim_set_hl(0, 'SpellBad', {
            undercurl = true,
            underline = true,  -- Fallback if undercurl not supported
            sp = '#E82424',    -- Red underline color
            fg = '#E82424',    -- Red text color for maximum visibility
        })
        vim.api.nvim_set_hl(0, 'SpellCap', {
            undercurl = true,
            underline = true,
            sp = '#DCA561',    -- Yellow for capitalization
        })
    end,

}
