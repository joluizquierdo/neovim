vim.opt.number = true -- Enable line numbers
vim.opt.relativenumber = true -- relative numbers
vim.opt.cursorline = true -- higlight current line

vim.opt.tabstop = 4 -- Display actuals \t as 4 spaces in the screen
vim.opt.shiftwidth = 4 -- Using '>', '<' or '=' when editing a buffer adds spaces instead of \t
vim.opt.softtabstop = 4 -- Tab/Backsapce in Insert mode moves 4 spaces
vim.opt.expandtab = true -- Tab key insert 4 spaces instead of \t

vim.opt.smartindent = true -- Try using smart indent if treesitter indenting is not available

vim.opt.wrap = false -- Do not wrap lines

-- Disable swap and backup anoying files
vim.opt.swapfile = false
vim.opt.backup = false
-- Configure undotree to remember changes in files
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true -- higlight search matcheo
vim.opt.incsearch = true -- show matches as you type

vim.opt.termguicolors = true

vim.opt.scrolloff = 15 -- keep some lines above below cursor

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.foldlevel = 99 -- start with all folds open

vim.opt.ignorecase = true -- ignore case when searching
vim.opt.smartcase = true -- case sensitive if uppercase in string

vim.opt.autoread = true -- auto-reload changes made outside of neovim

vim.opt.iskeyword:append("-") -- include - in words

vim.opt.splitbelow = true
vim.opt.splitright = true
