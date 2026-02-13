return {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
        'mason-org/mason.nvim',
        'neovim/nvim-lspconfig',
        'saghen/blink.cmp',
    },
    config = function()
        require('mason-lspconfig').setup({
            -- Servers to auto-install
            ensure_installed = {
                'lua_ls',        -- Lua
                'pyright',       -- Python
                'ts_ls',         -- TypeScript/JavaScript
                'gopls',         -- Go
                'rust_analyzer', -- Rust
                'terraformls',   -- Terraform
                'yamlls',        -- YAML
                'jsonls',        -- JSON
                'bashls',        -- Bash
            },

            -- Handlers for configuring LSP servers with blink.cmp capabilities
            handlers = {
                -- Default handler - applies to all servers
                function(server_name)
                    local capabilities = require('blink.cmp').get_lsp_capabilities()
                    require('lspconfig')[server_name].setup({
                        capabilities = capabilities
                    })
                end,

                -- Rust-analyzer specific configuration
                ['rust_analyzer'] = function()
                    local capabilities = require('blink.cmp').get_lsp_capabilities()
                    require('lspconfig').rust_analyzer.setup({
                        capabilities = capabilities,
                        settings = {
                            ['rust-analyzer'] = {
                                -- Fixes issue where diagnostics persist after fixing errors
                                checkOnSave = true,
                                -- Use clippy for additional lints
                                check = {
                                    command = "clippy"
                                }
                            }
                        }
                    })
                end,
            },
        })
    end,
}
