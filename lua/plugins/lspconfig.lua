return {
    'neovim/nvim-lspconfig',
    config = function()
        -- LSP keymaps and autocommands are set on the LspAttach event
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
            callback = function(event)
                -- Keymaps for LSP actions
                local map = function(keys, func, desc)
                    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                -- Jump to definition/declaration/references
                map('gd', vim.lsp.buf.definition, 'Go to definition')
                map('gD', vim.lsp.buf.declaration, 'Go to declaration')
                map('gr', vim.lsp.buf.references, 'Go to references')
                map('gI', vim.lsp.buf.implementation, 'Go to implementation')
                
                -- Code actions (leader>c group)
                map('<leader>ca', vim.lsp.buf.code_action, 'Code action')
                map('<leader>cr', vim.lsp.buf.rename, 'Rename')
                map('<leader>cs', require('telescope.builtin').lsp_document_symbols, 'Document symbols')
                map('<leader>cw', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace symbols')
                
                -- Documentation
                map('K', vim.lsp.buf.hover, 'Hover documentation')
                map('<C-k>', vim.lsp.buf.signature_help, 'Signature help')
                
                map('<leader>cd', vim.diagnostic.open_float, 'Show diagnostic')
                map('[d', function() vim.diagnostic.jump({ count = -1 }) end, 'Previous diagnostic')
                map(']d', function() vim.diagnostic.jump({ count = 1 }) end, 'Next diagnostic')
                
                -- Highlight references under cursor
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                    local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
                        end,
                    })
                end
            end,
        })

        -- Diagnostic configuration
        vim.diagnostic.config({
            virtual_text = true,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN] = " ",
                    [vim.diagnostic.severity.HINT] = " ",
                    [vim.diagnostic.severity.INFO] = " ",
                },
            },
            update_in_insert = false,
            underline = true,
            severity_sort = true,
            float = {
                border = 'rounded',
                source = true,
            },
        })
    end,
}
