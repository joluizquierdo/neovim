vim.pack.add({
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        version = "main",
        build = ":TSUpdate",
    }
})

-- Install parsers, check list here:
-- https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
local treesitter = require('nvim-treesitter')
-- Load treesitter, without this call some things
-- like folding will not work
treesitter.setup({})
treesitter.install({
    'lua',
    'python',
    'go',
    'rust',
    'typescript',
    'javascript',
    'bash',
    'zsh',
    'html',
    'helm',
    'terraform',
    'dockerfile',
    'json',
    'yaml',
    'vim',
    'vimdoc',
})

-- Enable TreeSitter highlight ,indentation and folding
local group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function(args)
        -- Attempt to start highlighting natively
        if pcall(vim.treesitter.start, args.buf) then
            -- If successful (parser exists), enable treesitter indentation
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            -- Use TreeSitter folding
            vim.opt_local.foldmethod = "expr"
            vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end
    end,
})
