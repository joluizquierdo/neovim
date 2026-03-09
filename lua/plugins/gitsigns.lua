-- Plugin Installation
vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

-- Configuration
local gitsigns = require('gitsigns')
gitsigns.setup({
    signs = {
        add          = { text = '○' },
        change       = { text = '◌' },
        delete       = { text = '╌' },
        topdelete    = { text = '╌' },
        changedelete = { text = '◌' },
        untracked    = { text = '·' },
    },
    signs_staged = {
        add          = { text = '●' },
        change       = { text = '◉' },
        delete       = { text = '━' },
        topdelete    = { text = '━' },
        changedelete = { text = '◉' },
        untracked    = { text = '•' },
    },
    signs_staged_enable = true,
    signcolumn = true,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = {
        follow_files = true
    },
    auto_attach = true,
    attach_to_untracked = false,
    current_line_blame = false,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil,
    max_file_length = 40000,
    preview_config = {
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
    on_attach = function(bufnr)
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']h', function()
            if vim.wo.diff then
                vim.cmd.normal({ ']c', bang = true })
            else
                gitsigns.nav_hunk('next', { target = 'all' })
            end
        end, { desc = 'Next git hunk' })

        map('n', '[h', function()
            if vim.wo.diff then
                vim.cmd.normal({ '[c', bang = true })
            else
                gitsigns.nav_hunk('prev', { target = 'all' })
            end
        end, { desc = 'Previous git hunk' })

        map('n', '<leader>gi', gitsigns.preview_hunk_inline, { desc = 'Preview hunk inline' })
        map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'Stage hunk' })
        map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'Reset hunk' })
        map('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'Stage buffer' })
        map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'Reset buffer' })

        map('n', '<leader>gb', function()
            gitsigns.blame_line({ full = true })
        end, { desc = 'Git: Blame line' })
        map('n', '<leader>gl', function()
            gitsigns.blame_line({ full = true })
        end, { desc = 'Git: Blame line' })

        map('n', '<leader>gd', function()
            gitsigns.diffthis('~')
        end, { desc = 'Git: Diff against last commit' })

        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Toggle git blame' })
        map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = 'Toggle word diff' })
        map('n', '<leader>tg', gitsigns.toggle_signs, { desc = 'Toggle git signs' })

        -- Text object
        map({ 'o', 'x' }, 'ig', gitsigns.select_hunk, { desc = 'Select git hunk' })
    end,
})
