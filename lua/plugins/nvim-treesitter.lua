return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
      -- Install parsers, check list of parsers here: 
      -- https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
      local treesitter = require('nvim-treesitter')
      treesitter.install({
          'lua',
          'python',
          'go',
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
  end,
}
