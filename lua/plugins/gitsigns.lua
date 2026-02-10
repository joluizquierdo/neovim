return {
	'lewis6991/gitsigns.nvim',
	event = { 'BufReadPre', 'BufNewFile' },
	config = function()
		local gitsigns = require('gitsigns')

		gitsigns.setup({
			signs = {
				add = { text = '┃' },
				change = { text = '┃' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
				untracked = { text = '┆' },
			},
			signs_staged = {
				add = { text = '┃' },
				change = { text = '┃' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
				untracked = { text = '┆' },
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
				map('n', ']c', function()
					if vim.wo.diff then
						vim.cmd.normal({ ']c', bang = true })
					else
						gitsigns.nav_hunk('next')
					end
				end, { desc = 'Next git hunk' })

				map('n', '[c', function()
					if vim.wo.diff then
						vim.cmd.normal({ '[c', bang = true })
					else
						gitsigns.nav_hunk('prev')
					end
				end, { desc = 'Previous git hunk' })

				-- Actions - using 'g' prefix instead of 'h'
				map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'Git: Stage hunk' })
				map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'Git: Reset hunk' })

				map('v', '<leader>gs', function()
					gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
				end, { desc = 'Git: Stage hunk' })

				map('v', '<leader>gr', function()
					gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
				end, { desc = 'Git: Reset hunk' })

				map('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'Git: Stage buffer' })
				map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'Git: Reset buffer' })
				map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = 'Git: Undo stage hunk' })
				map('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'Git: Preview hunk' })
				map('n', '<leader>gi', gitsigns.preview_hunk_inline, { desc = 'Git: Preview hunk inline' })

				map('n', '<leader>gb', function()
					gitsigns.blame_line({ full = true })
				end, { desc = 'Git: Blame line' })

				map('n', '<leader>gd', gitsigns.diffthis, { desc = 'Git: Diff this' })

				map('n', '<leader>gD', function()
					gitsigns.diffthis('~')
				end, { desc = 'Git: Diff against last commit' })

				map('n', '<leader>gQ', function()
					gitsigns.setqflist('all')
				end, { desc = 'Git: Load all hunks to quickfix' })

				map('n', '<leader>gq', gitsigns.setqflist, { desc = 'Git: Load hunks to quickfix' })

				-- Toggles
				map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Toggle git blame' })
				map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = 'Toggle word diff' })
				map('n', '<leader>tg', gitsigns.toggle_signs, { desc = 'Toggle git signs' })

				-- Text object
				map({ 'o', 'x' }, 'ig', gitsigns.select_hunk, { desc = 'Select git hunk' })
			end,
		})
	end,
}
