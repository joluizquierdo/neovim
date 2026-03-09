local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- highlight yanked text for a second
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Enable spell checking for markdown files
-- and auto wrap at 80 column
vim.api.nvim_create_autocmd({ 'FileType', 'BufEnter', 'BufWinEnter' }, {
    group = augroup,
    pattern = { 'markdown', 'text', 'gitcommit' },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = 'en_us,es' -- English + Spanish
        vim.opt_local.textwidth = 79
        -- t : Enables autowrapping at 'textwidth' when typing in INSERT mode
        -- c : Enables autowrapping at 'textwidth' for coments
        -- a : Enables automatic formatting of paragraphs. Every time you
        --     insert or delete text, Neovim will instantly reformat the
        --     entire paragraph in real-time to fit within the textwidth
        vim.opt_local.formatoptions:append("t")
    end,
})

-- return to last cursor position when you open a closed file
-- except in diff mode
vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup,
    desc = "Restore last cursor position",
    callback = function()
        if vim.o.diff then -- except in diff mode
            return
        end

        local last_pos = vim.api.nvim_buf_get_mark(0, '"') -- {line, col}
        local last_line = vim.api.nvim_buf_line_count(0)

        local row = last_pos[1]
        if row < 1 or row > last_line then
            return
        end

        pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
    end,
})
