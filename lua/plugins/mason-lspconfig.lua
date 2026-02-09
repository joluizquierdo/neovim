return {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
        'mason-org/mason.nvim',
        'neovim/nvim-lspconfig',
    },
    opts = {
        -- Servers to auto-install
        ensure_installed = {
            'lua_ls',        -- Lua
            'pyright',       -- Python
            'ts_ls',         -- TypeScript/JavaScript
            'gopls',         -- Go
            'terraformls',   -- Terraform
            'yamlls',        -- YAML
            'jsonls',        -- JSON
            'bashls',        -- Bash
        },
        -- Automatically enable installed servers
        automatic_enable = true,
    },
}
