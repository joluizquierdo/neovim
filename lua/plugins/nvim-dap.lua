vim.pack.add({
	-- dependencies
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/rcarriga/nvim-dap-ui",
	-- plugin
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/Weissle/persistent-breakpoints.nvim",
})

local dap = require("dap")

-- =========================================
-- Adapter: codelldb (with install check)
-- Install via :MasonInstall codelldb
-- =========================================
local codelldb_path = vim.fn.exepath("codelldb")
if codelldb_path == "" then
	vim.notify("nvim-dap: codelldb not found. Run :MasonInstall codelldb", vim.log.levels.WARN)
else
	dap.adapters.codelldb = {
		type = "server",
		port = "${port}",
		executable = {
			command = codelldb_path,
			args = { "--port", "${port}" },
		},
	}
end

-- =========================================
-- Fallback Rust configuration
-- Used when no .vscode/launch.json is present
-- =========================================
dap.configurations.rust = {
	{
		name = "Launch",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		sourceLanguages = { "rust" },
	},
}

-- =========================================
-- Per-project configs via .vscode/launch.json
-- Loaded automatically by nvim-dap on demand
-- =========================================
require("dap.ext.vscode").type_to_filetypes = {
	codelldb = { "rust", "c", "cpp" },
}

-- =========================================
-- Pre-debug build for Rust (cargo build)
-- Ensures binary matches source before debugging
-- =========================================
dap.listeners.on_config["rust-cargo-build"] = function(config)
	if config.type ~= "codelldb" then
		return config
	end

	-- Only run for Rust projects (check for Cargo.toml)
	if vim.fn.filereadable("Cargo.toml") ~= 1 then
		return config
	end

	vim.notify("Running cargo build...", vim.log.levels.INFO)

	local result = vim.system({ "cargo", "build" }, { cwd = vim.fn.getcwd(), text = true }):wait()

	if result.code ~= 0 then
		vim.notify("cargo build failed:\n" .. (result.stderr or ""), vim.log.levels.ERROR)
		return nil -- Abort debug session
	end

	vim.notify("Build succeeded", vim.log.levels.INFO)
	return config
end

-- =========================================
-- DAP UI setup
-- =========================================
local dapui = require("dapui")
dapui.setup()

-- Auto open/close UI with debug session
dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

-- =========================================
-- Persistent breakpoints
-- =========================================
require("persistent-breakpoints").setup({
	load_breakpoints_event = { "BufReadPost" },
})

-- =========================================
-- Keymaps — <Space>cd prefix (code debug)
-- =========================================
local opts = { noremap = true, silent = true }
local pb_api = require("persistent-breakpoints.api")

opts.desc = "Debug: continue / start"
vim.keymap.set("n", "<leader>cc", dap.continue, opts)

opts.desc = "Debug: step over"
vim.keymap.set("n", "<leader>cn", dap.step_over, opts)

opts.desc = "Debug: step into"
vim.keymap.set("n", "<leader>ci", dap.step_into, opts)

opts.desc = "Debug: step out"
vim.keymap.set("n", "<leader>co", dap.step_out, opts)

opts.desc = "Debug: toggle breakpoint"
vim.keymap.set("n", "<leader>cb", pb_api.toggle_breakpoint, opts)

opts.desc = "Debug: conditional breakpoint"
vim.keymap.set("n", "<leader>cB", pb_api.set_conditional_breakpoint, opts)

opts.desc = "Debug: clear all breakpoints"
vim.keymap.set("n", "<leader>cX", pb_api.clear_all_breakpoints, opts)

opts.desc = "Debug: terminate session"
vim.keymap.set("n", "<leader>ct", dap.terminate, opts)

opts.desc = "Debug: open REPL"
vim.keymap.set("n", "<leader>ce", dap.repl.open, opts)
