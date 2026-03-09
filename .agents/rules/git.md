# Git & Commit Convention

## Conventional Commits
```
<type>(<scope>): <short description>
```

**Types in use:** `feat`, `fix`, `refactor`, `style`

**Scope** is optional; refers to the plugin or config area:

| Scope examples | |
|---|---|
| `keymaps` | `lspconfig` |
| `gitsigns` | `treesitter` |
| `options` | `autocmds` |

## Examples
```
feat(keymaps): add keymap to forcefully save the buffer
fix(lspconfig): invalid keymaps and additional description
refactor(gitsigns): improve visuals and keymaps
style: format lua
```

## Notes
- After adding or updating a plugin, always commit the updated `nvim-pack-lock.json`.
- The `.gitignore` excludes only `spell/` (Neovim spell files).
