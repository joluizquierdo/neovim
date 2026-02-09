return {
    'saghen/blink.cmp',
    -- Optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },
    
    -- Use a release tag to download pre-built binaries
    version = '1.*',
    
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- Keymap preset
        -- 'default' for mappings similar to built-in completion (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' (selected) for Enter to accept - most intuitive
        -- See :h blink-cmp-config-keymap for custom keymaps
        keymap = { preset = 'enter' },
        
        -- Appearance
        appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono',
        },
        
        -- Completion settings
        completion = {
            -- Show documentation popup automatically when item is selected
            documentation = { 
                auto_show = true,
                auto_show_delay_ms = 200,
            },
        },
        
        -- Sources for completion
        sources = {
            -- Default enabled providers
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        
        -- Fuzzy matcher settings
        fuzzy = {
            -- Use Rust implementation with warning fallback to Lua if unavailable
            implementation = "prefer_rust_with_warning"
        },
    },
    
    -- Allow extending sources.default in other config files
    opts_extend = { "sources.default" },
}
