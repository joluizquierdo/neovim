# AGENTS.md - Neovim Configuration Development Guide

This document provides guidelines for AI coding agents working on this Neovim configuration repository.

## Primary Objectives

1. **Documentation Excellence**: Keep documentation simple, concise, and comprehensive. Every keymap, macro, and plugin feature must be documented like a user manual.
2. **Correctness First**: All configuration changes must work correctly before being committed.
3. **Plugin Simplification**: Favor simpler, more maintainable plugin configurations over complex setups.

## Build/Test Commands

This is a Neovim configuration repository with no traditional build/test system. Validation is done manually:

**Basic validation:**
```bash
# Start Neovim (tests if config loads without errors)
nvim

# Check health of all components
nvim +checkhealth

# Check LSP health specifically
nvim +":checkhealth vim.lsp" +q

# Check treesitter health
nvim +":checkhealth nvim-treesitter" +q

# View startup messages/errors
nvim +messages
```

**Testing plugin changes:**
```bash
# Open a test file with the language you're testing
nvim test.lua  # For Lua LSP/treesitter testing
nvim test.py   # For Python LSP/treesitter testing

# Inside Neovim, verify:
# - :LspInfo (check LSP attaches correctly)
# - :InspectTree (check treesitter parser loads)
# - :Lazy (check plugin status)
# - :Mason (check installed LSP servers)
```

**Testing specific keymaps:**
```bash
# Open Neovim with a test file
nvim test.lua

# Test the keymap manually
# Example: Press <leader>pf to test telescope file finder
# Example: Type some code and test LSP keymaps (gd, gr, K, etc.)
```

**No automated tests exist.** All testing is manual via opening Neovim and verifying functionality.

## File Structure

```
~/.config/nvim/
├── init.lua                    # Entry point - sets leader keys, loads config
├── lua/
│   ├── config/
│   │   ├── lazy.lua            # lazy.nvim bootstrap (rarely modified)
│   │   ├── options.lua         # Vim options (tabs, display, file handling)
│   │   └── keymaps.lua         # Global keymaps (non-plugin specific)
│   └── plugins/
│       ├── *.lua               # One file per plugin spec
```

## Code Style Guidelines

### File Organization

- **One plugin per file** in `lua/plugins/`
- **Plugin filename** should match plugin name (e.g., `telescope.lua` for telescope plugin)
- **Global keymaps** go in `lua/config/keymaps.lua`
- **Plugin-specific keymaps** go in the plugin's config file

### Plugin Configuration Patterns

**Prefer lazy-loading with `keys` when possible:**
```lua
return {
    'plugin/name',
    keys = {
        {'<leader>x', '<cmd>Command<cr>', desc = 'Description'},
    },
}
```

**For plugins requiring setup, use `config` function:**
```lua
return {
    'plugin/name',
    config = function()
        local plugin = require('plugin')
        plugin.setup({
            -- configuration here
        })
        
        -- Keymaps after setup
        vim.keymap.set('n', '<leader>x', function() plugin.action() end, { desc = 'Description' })
    end,
}
```

### Keymap Guidelines

**Always include `desc` for discoverability:**
```lua
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP: Code action' })
```

**Use function wrappers for complex actions:**
```lua
-- Good
vim.keymap.set('n', '<leader>ps', function()
    local builtin = require('telescope.builtin')
    builtin.grep_string({search = vim.fn.input("🔎 Grep > ")})
end, { desc = 'Search grep' })

-- Bad (mixing string commands with function calls)
vim.keymap.set('n', '<leader>ps', ':lua require("telescope.builtin").grep_string({search = vim.fn.input("🔎 Grep > ")})<cr>')
```

### Type Annotations

This configuration **does not use type annotations**. Keep code simple and readable without type hints.

### Naming Conventions

- **Variables**: `snake_case` (e.g., `local harpoon_files`)
- **Functions**: `snake_case` (e.g., `function toggle_telescope()`)
- **Constants**: `UPPER_SNAKE_CASE` for true constants (rare in this config)
- **Keymaps**: Use `<leader>` prefix for custom bindings

### Error Handling

**Use `pcall` for operations that might fail:**
```lua
-- Check if treesitter parser exists before enabling indent
if pcall(vim.treesitter.get_parser) then
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end
```

**Display errors to user when appropriate:**
```lua
if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
    }, true, {})
end
```

## Documentation Guidelines

### README.md Structure

The README.md must follow this exact structure:

1. **Setup** - Installation requirements and steps
2. **Overview** - File structure, leader key, core settings
3. **Plugins** - One section per plugin with:
   - Brief description (1-2 sentences)
   - Keymaps table with 3 columns: Keymap | Description
   - Commands (if applicable)
   - Features list (if complex plugin)
4. **General Keymaps** - Non-plugin keymaps organized by category
5. **Configuration Options** - All vim options from options.lua
6. **Useful Commands** - Common Neovim/plugin commands
7. **Adding New Plugins** - Brief guide
8. **Adding Support for New Languages** - Step-by-step guide

### Keymap Documentation Format

Always use this table format for keymaps:

```markdown
| Keymap | Description |
|--------|-------------|
| `<leader>pf` | Find files (all files) |
| `<C-p>` | Find git tracked files |
```

**Rules:**
- Wrap keymaps in backticks
- Use plain English descriptions (no technical jargon)
- Add context in parentheses when needed
- Sort by frequency of use (most common first)

### Plugin Documentation Requirements

Every plugin section must include:

1. **Plugin name** as heading
2. **One-sentence description** of what it does
3. **Keymaps table** (if plugin has keymaps)
4. **Commands section** (if plugin has commands)
5. **Usage examples** for complex features

**Example:**
```markdown
### LazyGit (Git Integration)
Terminal UI for git operations within Neovim.

| Keymap | Description |
|--------|-------------|
| `<leader>gg` | Open LazyGit |

**In LazyGit:**
- `?` - Show help/keybindings
- `q` - Quit LazyGit
```

## Common Tasks

### Adding a New Plugin

1. Create `lua/plugins/<plugin-name>.lua`
2. Use lazy.nvim spec format
3. Add keymaps with `desc` fields
4. Test by opening Neovim and running `:Lazy sync`
5. Update README.md with plugin documentation

### Adding Language Support

**Both steps required:**

1. Add treesitter parser to `lua/plugins/nvim-treesitter.lua`
2. Add LSP server to `lua/plugins/mason-lspconfig.lua`
3. Restart Neovim
4. Test with a file of that language
5. Update README.md language lists

### Updating Documentation

**After ANY config change:**

1. Update README.md to reflect changes
2. Keep explanations simple and concise
3. Add examples for complex features
4. Test all documented keymaps manually
5. Ensure README.md structure matches guidelines above

## Plugin Simplification Principles

1. **Avoid overengineering**: Use default plugin settings when possible
2. **Minimize dependencies**: Only add required dependencies
3. **Lazy load when possible**: Use `keys`, `cmd`, or `ft` for lazy loading
4. **No premature optimization**: Start simple, optimize if needed
5. **Delete unused features**: Remove keymaps/config for features not used

**Example - Good (simple):**
```lua
return {
    'plugin/name',
    keys = {
        {'<leader>x', '<cmd>Command<cr>', desc = 'Do thing'},
    },
}
```

**Example - Bad (overengineered):**
```lua
return {
    'plugin/name',
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { 'dep1', 'dep2', 'dep3' },
    config = function()
        -- 50 lines of custom config
    end,
}
```

## Commit Message Style

- Use convential commit 
- Use present tense ("Add feature" not "Added feature")
- Use imperative mood ("Move cursor" not "Moves cursor")
- First line: concise summary (50 chars or less)
- Reference issue numbers if applicable

**Examples:**
```
feat: add rust language support
refactor: telescope keymaps
fix: treesitter indentation for python
```
---

**Remember**: Documentation quality is the highest priority. Every change must be documented clearly and concisely in README.md.
