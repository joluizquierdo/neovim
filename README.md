# Neovim Configuration

Minimal Neovim configuration using Lua and lazy.nvim package manager.

## Setup

### Requirements
- Neovim 0.11.0+ (nightly)
- `tree-sitter-cli` (install via `brew install tree-sitter-cli`)
- C compiler
- `curl` and `tar`

### Installation
```bash
# Clone or create config
git clone <your-repo> ~/.config/nvim

# Start Neovim (lazy.nvim will auto-install on first run)
nvim

# Parsers will install automatically in background (takes 2-5 minutes first time)
```

## Overview

**Structure:**
```
~/.config/nvim/
├── init.lua              # Entry point, sets leader keys
├── lua/
│   ├── config/
│   │   ├── lazy.lua      # lazy.nvim bootstrap
│   │   ├── options.lua   # Vim options (tabs, indents, etc.)
│   │   └── keymaps.lua   # Custom keymaps
│   └── plugins/
│       ├── kanagawa.lua  # Colorscheme
│       ├── telescope.lua # Fuzzy finder
│       ├── harpoon.lua   # Quick file navigation
│       ├── undotree.lua  # Undo history visualizer
│       └── nvim-treesitter.lua # Syntax highlighting
```

**Leader Key:** `Space`

**Core Settings:**
- Tab width: 4 spaces
- Expand tabs: enabled (spaces instead of tabs)

## Plugins

### Telescope (Fuzzy Finder)
| Keymap | Description |
|--------|-------------|
| `<leader>pf` | Find files (all files) |
| `<leader>pb` | Find buffers |
| `<Ctrl-p>` | Find git tracked files |
| `<leader>ps` | Grep search (prompt for search term) |

### Harpoon (Quick File Navigation)
Mark and quickly navigate between frequently used files.

| Keymap | Description |
|--------|-------------|
| `<leader>ha` | Add current file to Harpoon |
| `<leader>h` | List Harpoon marks in Telescope (read-only) |
| `<leader>he` | Edit Harpoon marks (manage menu) |
| `<leader>1-4` | Jump to Harpoon file 1-4 |
| `<leader>hp` | Previous Harpoon file |
| `<leader>hn` | Next Harpoon file |

**Managing marks (in edit menu with `<leader>he`):**
- `j/k` or arrows - Navigate
- `Enter` - Open file
- `d` or `dd` - Delete mark
- Visual select + move - Reorder marks
- `q` or `<Esc>` - Close and save

### Undotree (Undo History)
Visualize and navigate your undo history as a tree.

| Keymap | Description |
|--------|-------------|
| `<leader>u` | Toggle undotree panel |

**In undotree panel:**
- `j/k` - Navigate through undo history
- `Enter` - Restore to selected state
- View timestamps and change previews
- `q` - Close panel

### TreeSitter (Syntax Highlighting)
| Command | Description |
|---------|-------------|
| `:InspectTree` | Show syntax tree for current buffer |
| `:Inspect` | Show treesitter node under cursor |
| `:TSInstall <lang>` | Install parser for language |
| `:TSUpdate` | Update all installed parsers |

**Installed Parsers:** lua, python, go, typescript, javascript, bash, zsh, html, helm, terraform, dockerfile, json, yaml, vim, vimdoc

### Kanagawa (Colorscheme)
Active colorscheme. Auto-loads on startup.

### General Keymaps
| Keymap | Description |
|--------|-------------|
| `<leader>pv` | Open file explorer (netrw) |
| `<leader>qq` | Quit all windows |

## Useful Commands

**Netrw (File Explorer):**
- `<Ctrl-L>` - Refresh file listing
- `%` - Create new file
- `d` - Create new directory
- `D` - Delete file/directory
- `-` - Go up one directory

```vim
:Lazy               " Open lazy.nvim plugin manager UI
:Lazy sync          " Update all plugins
:checkhealth        " Check Neovim health
:messages           " View startup messages/errors
```

## Adding New Plugins

Create a new file in `lua/plugins/<plugin-name>.lua`:
```lua
return {
    'author/plugin-name',
    -- config here
}
```

## Notes

- First startup takes 2-5 minutes for TreeSitter parsers to compile
- Check `:messages` for any installation errors
- Use `:Lazy` to manage plugins
