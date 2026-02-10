# AGENTS.md - Neovim Configuration Development Guide

Guidelines for AI coding agents working on this Neovim configuration repository.

## Primary Objectives

1. **Documentation Excellence**: Every keymap and plugin feature must be documented
2. **Correctness First**: All changes must work before being committed
3. **Simplicity**: Favor simple, maintainable configurations over complex setups

## Testing Commands

No automated tests. Validate manually:

```bash
nvim                              # Test config loads
nvim +checkhealth                 # Check all components
nvim +":checkhealth vim.lsp"      # Check LSP
nvim +messages                    # View startup errors
```

## File Structure

```
~/.config/nvim/
├── init.lua                 # Entry point
├── README.md                # Main docs (NO keymaps)
├── cheatsheet/README.md     # ALL keymaps (single source of truth)
├── lua/config/
│   ├── options.lua          # Vim options
│   └── keymaps.lua          # Global keymaps
└── lua/plugins/*.lua        # One file per plugin
```

## Code Style

### Plugin Configuration

```lua
# Simple (preferred)
return {
    'plugin/name',
    keys = {
        {'<leader>x', '<cmd>Command<cr>', desc = 'Description'},
    },
}

# With setup
return {
    'plugin/name',
    config = function()
        require('plugin').setup({ })
        vim.keymap.set('n', '<leader>x', func, { desc = 'Description' })
    end,
}
```

### Naming & Style

- Variables/functions: `snake_case`
- No type annotations
- Always include `desc` in keymaps
- Use `pcall` for operations that might fail
- Prefer function wrappers over string commands in keymaps

## Documentation Rules

### CRITICAL: Keymap Documentation

- **ALL keymaps** go in `cheatsheet/README.md` ONLY
- **NO keymaps** in `README.md` (prevents duplication)

### README.md Plugin Sections

Each plugin section must include:
1. Brief description (1-2 sentences)
2. **Features list** (what it does, NO keymaps)
3. Commands (if applicable)
4. Usage examples (if complex)

**Example:**
```markdown
### LazyGit (Git Integration)
Terminal UI for git operations within Neovim.

**Features:**
- Auto-configured colorscheme
- Integration with Neovim for commit messages
- Opens in floating window

**In LazyGit:**
- `?` - Show help
- `q` - Quit
```

### Cheatsheet Format

```markdown
| Keymap | Mode | Description | Source |
|--------|------|-------------|--------|
| `<leader>pf` | Normal | Find files | Telescope |
```

**Rules:**
- Plain English descriptions
- Sort by frequency of use
- Include mode and source

## Common Tasks

### Adding a Plugin

1. Create `lua/plugins/<plugin-name>.lua`
2. Add keymaps with `desc` fields
3. Test: `:Lazy sync` in Neovim
4. Update README.md (features only)
5. Update cheatsheet/README.md (keymaps)

### Adding Language Support

1. Add parser to `lua/plugins/nvim-treesitter.lua`
2. Add LSP server to `lua/plugins/mason-lspconfig.lua`
3. Restart Neovim
4. Test with language file
5. Update README.md language lists

### Updating Documentation

**After ANY config change:**
1. Update README.md (features/commands, NO keymaps)
2. Update cheatsheet/README.md (if keymaps changed) - **CRITICAL**
3. Test keymaps manually

**Workflow:**
```
1. Add keymap to lua/plugins/someplugin.lua
2. Update README.md plugin features
3. Update cheatsheet/README.md keymap table
4. Test keymap works
5. Commit together
```

## Simplification Principles

1. Use default plugin settings when possible
2. Minimize dependencies
3. Lazy load with `keys`, `cmd`, or `ft`
4. Start simple, optimize only if needed
5. Remove unused features

## Commit Messages

Use conventional commits:
- `feat: add rust language support`
- `refactor: simplify telescope config`
- `fix: treesitter indentation`

---

**Remember**: Documentation quality is the highest priority. Keymaps ONLY in cheatsheet.
