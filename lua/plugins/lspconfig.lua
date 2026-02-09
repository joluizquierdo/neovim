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
                map('<leader>D', vim.lsp.buf.type_definition, 'Type definition')
                
                -- Symbols
                map('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document symbols')
                map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace symbols')
                
                -- Code actions
                map('<leader>ca', vim.lsp.buf.code_action, 'Code action')
                map('<leader>rn', vim.lsp.buf.rename, 'Rename')
                
                -- Documentation
                map('K', vim.lsp.buf.hover, 'Hover documentation')
                map('<C-k>', vim.lsp.buf.signature_help, 'Signature help')
                
                -- Diagnostics
                map('<leader>e', vim.diagnostic.open_float, 'Show diagnostic')
                map('[d', vim.diagnostic.goto_prev, 'Previous diagnostic')
                map(']d', vim.diagnostic.goto_next, 'Next diagnostic')
                
                -- Highlight references under cursor
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
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
            signs = true,
            update_in_insert = false,
            underline = true,
            severity_sort = true,
            float = {
                border = 'rounded',
                source = true,
            },
        })

        -- Customize diagnostic signs
        local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
    end,
}
