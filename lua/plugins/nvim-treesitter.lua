vim.pack.add({
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
		build = ":TSUpdate",
	},
})

-- Install parsers, check list here:
-- https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
local treesitter = require("nvim-treesitter")
-- Load treesitter, without this call some things
-- like folding will not work
treesitter.setup({})
treesitter.install({
	"lua",
	"python",
	"go",
	"gotmpl",
	"rust",
	"typescript",
	"javascript",
	"bash",
	"zsh",
	"html",
	"helm",
	"terraform",
	"dockerfile",
	"json",
	"yaml",
	"vim",
	"vimdoc",
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

-- =========================================
-- Configure Custom parsers: helm
-- =========================================

-- Set filetype for helm files
vim.filetype.add({
	extension = {
		gotmpl = "gotmpl",
	},
	pattern = {
		[".*/templates/.*%.tpl"] = "helm",
		[".*/templates/.*%.ya?ml"] = "helm",
		["helmfile.*%.ya?ml"] = "helm",
	},
})

-- Monkey patch to fix folding in helm files:
-- The `helm` filetype uses language injection: the `helm`/`gotmpl` parser
-- handles Go template syntax and injects the `yaml` parser for YAML content
-- between template tags. Each injected YAML region is its own isolated parse
-- tree, so treesitter's incremental re-parse only updates the region that was
-- edited. As a result, `vim.treesitter.foldexpr()` only recomputes folds for
-- the scope that was touched, leaving other regions stale until they are
-- edited. Running `zx` after every save forces a full fold recomputation for
-- the entire buffer, keeping all folds consistent.
local helm_fold_group = vim.api.nvim_create_augroup("HelmFoldRefresh", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = helm_fold_group,
	pattern = {
		"*/templates/*.yaml",
		"*/templates/*.yml",
		"*/templates/*.tpl",
		"helmfile*.yaml",
		"helmfile*.yml",
	},
	callback = function()
		-- This function execute the command after some time have passed
		-- because treesitter must be completely initialized before refreshing
		-- the foldings
		vim.defer_fn(function()
			vim.cmd("normal! zx") -- zx refresh all folds in the current buffer
		end, 350)
	end,
})
