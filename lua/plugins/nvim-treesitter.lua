return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
      -- Install parsers, check list here: 
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
      -- Enable TreeSitter indentation globally
      vim.api.nvim_create_autocmd('FileType', {
          pattern = '*',
          callback = function()
              -- Enable TreeSitter-based indentation if parser is available
              if pcall(vim.treesitter.get_parser) then
                  vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
              end
          end,
      })
  end,
}
