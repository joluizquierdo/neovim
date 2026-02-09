vim.opt.nu = true -- Enable line numbers
vim.opt.relativenumber = true -- relative numbers


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

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 15

vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
