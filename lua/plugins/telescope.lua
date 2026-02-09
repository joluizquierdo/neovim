return {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    keys = {
        {'<leader>pf', '<cmd>Telescope find_files<cr>', desc = 'Find files'},
        {'<leader>pb', '<cmd>Telescope buffers<cr>', desc = 'Buffers'},
        {'<C-p>', '<cmd>Telescope git_files<cr>', desc = 'All files that are tracked by git'},
        {
            '<leader>ps', 
            function ()
                local builtin = require('telescope.builtin')
                builtin.grep_string({search = vim.fn.input("🔎 Grep > ")});
            end, 
            desc = 'Search grep'
        },

    },
}
