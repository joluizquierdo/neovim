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
│       ├── lazygit.lua   # Git integration
│       ├── mason.lua     # LSP/tool installer
│       ├── mason-lspconfig.lua # LSP auto-config
│       ├── lspconfig.lua # LSP keymaps & setup
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

### LazyGit (Git Integration)
Terminal UI for git operations within Neovim.

| Keymap | Description |
|--------|-------------|
| `<leader>gg` | Open LazyGit |

**In LazyGit:**
- `?` - Show help/keybindings
- `q` - Quit LazyGit

### LSP (Language Server Protocol)
Provides IDE-like features: autocomplete, go-to-definition, diagnostics, etc.

**Auto-installed servers:** lua_ls, pyright, ts_ls, gopls, terraformls, yamlls, jsonls, bashls

| Keymap | Description |
|--------|-------------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `<leader>D` | Type definition |
| `<leader>ds` | Document symbols (Telescope) |
| `<leader>ws` | Workspace symbols (Telescope) |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename symbol |
| `K` | Hover documentation |
| `<Ctrl-k>` | Signature help |
| `<leader>e` | Show diagnostic |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

**Commands:**
- `:Mason` - Open Mason UI to manage LSP servers
- `:LspInfo` - Show LSP status
- `:LspInstall <server>` - Install LSP server
- `:LspRestart` - Restart LSP servers

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

## Adding Support for New Languages

To add support for a new language, you **must** complete both steps below:

### Step 1: Add TreeSitter Parser (Required for Syntax Highlighting)

**1a.** Find the parser name for your language at [https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
](https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
)
**1b.** Edit `lua/plugins/nvim-treesitter.lua` and add the language to the `install()` list:

```lua
treesitter.install({
    'lua',
    'python',
    -- ... existing languages ...
    'rust',  -- Add your language here
})
```

Restart Neovim and the parser will install automatically.

### Step 2: Add LSP Server (Required for IDE Features)

**2a.** Find the LSP server name for your language at [https://mason-registry.dev/registry/list](https://mason-registry.dev/registry/list)

**2b.** Edit `lua/plugins/mason-lspconfig.lua` and add the server to `ensure_installed`:

```lua
ensure_installed = {
    'lua_ls',
    'pyright',
    -- ... existing servers ...
    'rust_analyzer',  -- Add your LSP server here
},
```

**2c.** Restart Neovim. The LSP server will install automatically via Mason.

**2d.** Open a file with that language. LSP will attach automatically and provide:
- Autocomplete
- Go to definition
- Diagnostics
- Code actions
- Hover documentation

### Step 3: Verify Installation (Optional but Recommended)

1. Run `:checkhealth vim.lsp` to verify LSP is working
2. Run `:InspectTree` in a file to verify TreeSitter parser is active
3. Run `:Mason` to see installed servers

### Complete Example: Adding Rust Support

Here's what the full procedure looks like for adding Rust:

```lua
-- In nvim-treesitter.lua
treesitter.install({
    -- ... other languages ...
    'rust',
})

-- In mason-lspconfig.lua
ensure_installed = {
    -- ... other servers ...
    'rust_analyzer',
},
```

Restart Neovim, open a `.rs` file, and you'll have full Rust support!

## Notes

- First startup takes 2-5 minutes for TreeSitter parsers to compile
- Check `:messages` for any installation errors
- Use `:Lazy` to manage plugins
