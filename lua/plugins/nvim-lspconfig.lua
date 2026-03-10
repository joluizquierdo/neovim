vim.pack.add({
	-- dependencies
	"https://github.com/mason-org/mason.nvim", -- for installing LSPs
	"https://github.com/b0o/SchemaStore.nvim", -- for JSON and YAML schemas
	"https://github.com/mason-org/mason-lspconfig.nvim", -- automatically enable and install LSPs
	"https://github.com/stevearc/conform.nvim", -- format the code
	"https://github.com/mfussenegger/nvim-lint", -- lint code
	-- plugin
	"https://github.com/neovim/nvim-lspconfig",
})

local diagnostic_signs = {
	Error = "❌",
	Warn = "⚠️",
	Hint = "💡",
	Info = "ℹ️",
}

vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
			[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		header = "",
		prefix = "",
		focusable = false,
		style = "minimal",
	},
})

local function lsp_on_attach(ev)
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	if not client then
		vim.notify("LSP not attached: client_id " .. ev.data.client_id .. " not found", vim.log.levels.WARN)
		return
	end

	local bufnr = ev.buf
	local opts = { noremap = true, silent = true, buffer = bufnr }
	if client:supports_method("textDocument/codeAction", bufnr) then
		opts.desc = "LSP Organize imports"
		vim.keymap.set("n", "<leader>co", function()
			vim.lsp.buf.code_action({
				context = { only = { "source.organizeImports" }, diagnostics = {} },
				apply = true,
				bufnr = bufnr,
			})
			vim.defer_fn(function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, 50)
		end, opts)
	end

	opts.desc = "Go to declaration"
	vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)

	opts.desc = "Go to definition"
	vim.keymap.set("n", "gD", vim.lsp.buf.definition, opts)

	opts.desc = "Go to definition in vsplit"
	vim.keymap.set("n", "gS", function()
		vim.cmd("vsplit")
		vim.lsp.buf.definition()
	end, opts)

	opts.desc = "Code action"
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

	opts.desc = "Rename"
	vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)

	opts.desc = "Jump next diagnostic"
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.jump({ count = 1 })
	end, opts)
	opts.desc = "Jump prev diagnostic"
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.jump({ count = -1 })
	end, opts)

	opts.desc = "Hover"
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	opts.desc = "Signature Help"
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

	opts.desc = "Definitions"
	vim.keymap.set("n", "<leader>ld", function()
		require("telescope.builtin").lsp_definitions()
	end, opts)
	opts.desc = "References"
	vim.keymap.set("n", "<leader>lr", function()
		require("telescope.builtin").lsp_references()
	end, opts)
	opts.desc = "Type definitions"
	vim.keymap.set("n", "<leader>lt", function()
		require("telescope.builtin").lsp_type_definitions()
	end, opts)
	opts.desc = "Document symbols"
	vim.keymap.set("n", "<leader>ls", function()
		require("telescope.builtin").lsp_document_symbols()
	end, opts)
	opts.desc = "Worspace Symbols"
	vim.keymap.set("n", "<leader>lw", function()
		require("telescope.builtin").lsp_workspace_symbols()
	end, opts)
	opts.desc = "Implementatins"
	vim.keymap.set("n", "<leader>li", function()
		require("telescope.builtin").lsp_implementations()
	end, opts)

	opts.desc = "Diagnostic Line"
	vim.keymap.set("n", "<leader>dd", function()
		vim.diagnostic.open_float({ scope = "line" })
	end, opts)
	opts.desc = "Diagnostic cursor"
	vim.keymap.set("n", "<leader>dc", function()
		vim.diagnostic.open_float({ scope = "cursor" })
	end, opts)
end

vim.keymap.set("n", "<leader>dl", function()
	vim.diagnostic.setloclist({ open = true })
end, { desc = "Open diagnostic list" })

local augroup = vim.api.nvim_create_augroup("LSPUserConfig", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", { group = augroup, callback = lsp_on_attach })

-- =========================================
-- Configure mason (LSP installer)
-- =========================================

require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		-- LSP
		"lua_ls",
		"rust_analyzer",
		"bashls",
		"ts_ls", -- typescript
		"jsonls",
		"yamlls",
		"helm_ls",
		"tofu_ls",
		"tflint",
	},
})

-- WARNING:
-- Formatters and linters MUST be installed externally
-- either globally using brew, cargo, npm...
-- or individually per project

-- =========================================
-- Configure conform.nvim (Formatting)
-- =========================================
vim.api.nvim_create_user_command("FormatToggle", function()
	-- Toggle the buffer-local variable
	local is_disabled = vim.b.disable_autoformat or false
	vim.b.disable_autoformat = not is_disabled

	-- Provide user feedback
	if vim.b.disable_autoformat then
		vim.notify("Autoformat disabled for current buffer", vim.log.levels.INFO)
	else
		vim.notify("Autoformat enabled for current buffer", vim.log.levels.INFO)
	end
end, {
	desc = "Toggle autoformat-on-save for the current buffer",
})

local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		-- WARNING:
		-- intall tofu so the formatter is available
		terraform = { "tofu_fmt" },
		tf = { "tofu_fmt" },
		terraform_vars = { "tofu_fmt" },
		lua = { "stylua" },
		javascript = { "prettier" },
		typescript = { "prettier" },
	},
	format_on_save = function(bufnr)
		-- Disable with a global or buffer-local variable
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end

		return { timeout_ms = 500, lsp_format = "fallback" }
	end,
})

-- Keymap to trigger formatting manually
vim.keymap.set({ "n", "v" }, "<leader>cf", function()
	conform.format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer (Conform)" })

-- Maps <leader>tf to run the :FormatToggle command
vim.keymap.set("n", "<leader>tf", "<cmd>FormatToggle<CR>", {
	desc = "Toggle format on save for current buffer",
})

-- =========================================
-- Configure nvim-lint (Diagnostics)
-- =========================================
local lint = require("lint")
lint.linters_by_ft = {
	terraform = { "tflint", "tfsec" },
	tf = { "tflint", "tfsec" },
	typescript = { "eslint" },
	javascript = { "eslint" },
}

-- Native autocommand to trigger linting on file enter, save, and exit insert mode
local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint()
	end,
})
