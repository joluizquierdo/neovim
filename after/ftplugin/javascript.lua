-- Some formatters configured by the LSP or Conform will
-- format code using the adecuate indenting for each language.
-- However, the editing expirience will be awful if we don't set
-- the correct indenting for that specific file.
-- This is the purpose of this file.

-- Convert tabs to spaces
vim.opt_local.expandtab = true

-- Number of spaces a <Tab> counts for
vim.opt_local.tabstop = 2

-- Number of spaces to use for each step of (auto)indent
vim.opt_local.shiftwidth = 2

-- Number of spaces a <Tab> counts for while performing editing operations
vim.opt_local.softtabstop = 2

