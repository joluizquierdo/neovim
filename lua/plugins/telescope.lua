-- Define a hook to compile the C extension when installed or updated
local hooks = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
    -- Run 'make' synchronously in the plugin's downloaded directory
    vim.system({ 'make' }, { cwd = ev.data.path }):wait()
  end
end

-- Attach the hook BEFORE calling vim.pack.add()
vim.api.nvim_create_autocmd('PackChanged', { callback = hooks })

-- Plugin Installation
vim.pack.add({
    -- dependencies
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
    -- plugin
    "https://github.com/nvim-telescope/telescope.nvim",
})

-- Plugin config
require('telescope').setup({
  defaults = {
    -- Overwrite the default ripgrep arguments for live_grep/grep_string
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",           -- Include hidden files
      "--glob=!.git/",      -- Explicitly exclude the .git directory
    },
  },
  pickers = {
    find_files = {
      -- Overwrite the default find_files command to use ripgrep
      find_command = {
        "rg",
        "--files",
        "--hidden",
        "--glob=!.git/"
      },
    },
  },
})

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>pb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>pg', builtin.git_files, { desc = 'All files that are tracked by git' })
vim.keymap.set('n', '<leader>pl', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input('Grep > ') })
end, {
  desc = 'Search grep',
})

