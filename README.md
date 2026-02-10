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
│       ├── opencode.lua  # AI coding assistant
│       ├── snacks.lua    # UI utilities library
│       ├── blink-cmp.lua # Autocompletion engine
│       ├── mason.lua     # LSP/tool installer
│       ├── mason-lspconfig.lua # LSP auto-config & blink.cmp integration
│       ├── lspconfig.lua # LSP keymaps & setup
│       └── nvim-treesitter.lua # Syntax highlighting & indentation
```

**Leader Key:** `Space`

**Core Settings:**
- Tab width: 4 spaces
- Expand tabs: enabled (spaces instead of tabs)
- Smart indent: enabled (basic auto-indentation)
- TreeSitter indent: enabled (language-aware auto-indentation)

### How Indentation Works

This configuration uses a **two-layer indentation system**:

1. **`smartindent`** (lua/config/options.lua) - Basic C-like auto-indentation
   - Adds indent after `{`, `if`, `for`, `while`, etc.
   - Removes indent when typing `}`
   - Fast fallback for languages without TreeSitter support

2. **TreeSitter indentation** (lua/plugins/nvim-treesitter.lua) - Advanced language-aware
   - Uses syntax tree analysis for accurate indentation
   - Understands language-specific syntax (Python blocks, JSX, etc.)
   - Automatically enabled when TreeSitter parser is available
   - Falls back to `smartindent` when parser is not installed

**Configuration files:**
- `lua/config/options.lua` - Tab/indent settings and `smartindent`
- `lua/plugins/nvim-treesitter.lua` - TreeSitter indent via autocmd

## Plugins

### OpenCode (AI Coding Assistant)
In-editor AI assistant powered by Claude for code generation, refactoring, and questions.

| Keymap | Description |
|--------|-------------|
| `<C-a>` | Ask OpenCode (with current context) |
| `<C-x>` | Execute OpenCode action menu |
| `<C-.>` | Toggle OpenCode panel |
| `go` | Add visual range to OpenCode |
| `goo` | Add current line to OpenCode |
| `<S-C-u>` | Scroll OpenCode panel up |
| `<S-C-d>` | Scroll OpenCode panel down |
| `+` | Increment number under cursor |
| `-` | Decrement number under cursor |

**Features:**
- Ask questions about code with `<C-a>`
- Select from common actions with `<C-x>`
- Send code ranges to OpenCode with `go` in visual mode
- Persistent chat history across sessions
- Context-aware suggestions using `@this` prefix

**Note:** The default `<C-a>` and `<C-x>` keymaps conflict with Vim's increment/decrement. Use `+` and `-` instead for those operations.

### Snacks.nvim (UI Utilities)
Lightweight UI utilities library providing input prompts, pickers, and terminal windows. Used as backend for OpenCode plugin.

**Features:**
- Input prompts for interactive dialogs
- Picker interface for selections
- Terminal integration

**Note:** Only input, picker, and terminal modules are enabled. This plugin runs transparently in the background.

### Telescope (Fuzzy Finder)
| Keymap | Description |
|--------|-------------|
| `<leader>pf` | Find files (all files) |
| `<leader>pb` | Find buffers |
| `<Ctrl-p>` | Find git tracked files |
| `<leader>ps` | Grep search (prompt for search term) |

### Blink Completion (blink.cmp)
**Performant, batteries-included autocompletion plugin** with fuzzy matching and multiple sources.

Completions appear automatically as you type with intelligent ranking and typo resistance.

#### Keymaps (preset = 'enter')

**In Insert Mode:**
| Keymap | Description |
|--------|-------------|
| `<CR>` (Enter) | Accept selected completion |
| `<C-Space>` | Open completion menu / Show documentation |
| `<C-n>` or `↓` | Select next item |
| `<C-p>` or `↑` | Select previous item |
| `<C-e>` | Close completion menu |
| `<C-k>` | Toggle signature help |

**Completion Sources:**
- **LSP** - Language server suggestions (functions, variables, types)
- **Path** - File system paths
- **Snippets** - Code snippets from friendly-snippets
- **Buffer** - Words from open buffers

**Features:**
- ⚡ **High performance** - Rust-based fuzzy matcher (0.5-4ms)
- 🎯 **Typo resistant** - Fuzzy matching with frecency and proximity bonus
- 📚 **Automatic documentation** - Shows popup with details and examples
- 🔧 **LSP integration** - Full LSP completion support
- 📦 **Batteries included** - Works out of the box with sensible defaults
- 🎨 **Ghost text** - Inline preview of completions

**Commands:**
- `:BlinkCmpShow` - Manually trigger completion
- `:BlinkCmpHide` - Hide completion menu
- `:BlinkCmpToggle` - Toggle completion

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

**Auto-installed servers:** lua_ls, pyright, ts_ls, gopls, rust_analyzer, terraformls, yamlls, jsonls, bashls

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

### TreeSitter (Syntax Highlighting & Indentation)
Provides advanced syntax highlighting and language-aware auto-indentation.

| Command | Description |
|---------|-------------|
| `:InspectTree` | Show syntax tree for current buffer |
| `:Inspect` | Show treesitter node under cursor |
| `:TSInstall <lang>` | Install parser for language |
| `:TSUpdate` | Update all installed parsers |

**Installed Parsers:** lua, python, go, rust, typescript, javascript, bash, zsh, html, helm, terraform, dockerfile, json, yaml, vim, vimdoc

**Indentation Features:**
- Automatically enables TreeSitter-based indentation for files with available parsers
- Falls back to `smartindent` for languages without TreeSitter parsers
- Respects your tab settings (4 spaces per indent level)
- Use `=` in visual mode or `gg=G` to auto-indent entire file

### Kanagawa (Colorscheme)
Active colorscheme. Auto-loads on startup.

### General Keymaps

All custom keymaps are defined in `lua/config/keymaps.lua`:

#### Navigation & Window Management
| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>pv` | Normal | Open file explorer (netrw) |
| `<leader>qq` | Normal | Quit all windows |

#### Moving & Editing Text
| Keymap | Mode | Description |
|--------|------|-------------|
| `J` | Visual | Move selected lines down (maintains indentation) |
| `K` | Visual | Move selected lines up (maintains indentation) |
| `J` | Normal | Join line below with space, keep cursor position |
| `<C-d>` | Normal | Half-page down, cursor stays centered |
| `<C-u>` | Normal | Half-page up, cursor stays centered |
| `n` | Normal | Next search result, cursor stays centered |
| `N` | Normal | Previous search result, cursor stays centered |

#### Clipboard & Registers
| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>y` | Normal/Visual | Yank to system clipboard |
| `<leader>Y` | Normal | Yank line to system clipboard |
| `<leader>p` | Visual | Paste without losing clipboard content |
| `<leader>d` | Normal/Visual | Delete without saving to clipboard |

#### Find & Replace
| Keymap | Mode | Description |
|--------|------|-------------|
| `<leader>s` | Normal | Find & replace word under cursor (interactive) |

#### Utility
| Keymap | Mode | Description |
|--------|------|-------------|
| `<C-c>` | Insert | Exit insert mode (same as Esc, fixes visual-block mode) |
| `<leader>x` | Normal | Make current file executable (chmod +x) |
| `Q` | Normal | Disabled (prevents accidental Ex mode) |

#### Keymap Tips & Examples

**Moving Lines (Visual J/K):**
- Select lines with `V` (visual-line mode)
- Press `J` to move down or `K` to move up
- Keeps selection active - press multiple times to move further
- Auto-indents moved lines

**Smart Paste (`<leader>p`):**
- Yank text with `y`
- Select text you want to replace with visual mode
- Press `<leader>p` to paste without losing your yanked text
- Useful when replacing multiple occurrences

**Find & Replace (`<leader>s`):**
- Place cursor on word you want to replace
- Press `<leader>s`
- Type replacement text and press Enter
- Interactive - shows matches as you type

**System Clipboard (`<leader>y`):**
- Works like normal `y` but copies to system clipboard
- Paste in other applications with Cmd+V (Mac) or Ctrl+V (Linux/Windows)
- Use `<leader>Y` to copy entire line

**Centered Scrolling (`<C-d>`, `<C-u>`, `n`, `N`):**
- Keeps cursor in middle of screen while navigating
- Reduces eye movement and improves focus
- Especially useful when searching with `/`

## Configuration Options

All vim options are configured in `lua/config/options.lua`:

### Display Options
| Option | Value | Description |
|--------|-------|-------------|
| `nu` | `true` | Enable line numbers |
| `relativenumber` | `true` | Show relative line numbers |
| `wrap` | `false` | Don't wrap long lines |
| `termguicolors` | `true` | Enable 24-bit RGB colors |
| `scrolloff` | `15` | Keep 15 lines visible above/below cursor |
| `colorcolumn` | `"80"` | Show vertical line at column 80 |

### Indentation Options
| Option | Value | Description |
|--------|-------|-------------|
| `tabstop` | `4` | Display tabs as 4 spaces wide |
| `shiftwidth` | `4` | Indent by 4 spaces with `>`, `<`, `=` |
| `softtabstop` | `4` | Tab/Backspace moves 4 spaces in insert mode |
| `expandtab` | `true` | Insert spaces instead of tab character |
| `smartindent` | `true` | Enable smart auto-indentation (C-like) |

**Note:** TreeSitter provides advanced language-aware indentation on top of these settings.

### File Management Options
| Option | Value | Description |
|--------|-------|-------------|
| `swapfile` | `false` | Disable swap files (.swp) |
| `backup` | `false` | Disable backup files (~) |
| `undofile` | `true` | Enable persistent undo history |
| `undodir` | `~/.vim/undodir` | Directory for undo history files |

### Search Options
| Option | Value | Description |
|--------|-------|-------------|
| `hlsearch` | `false` | Don't highlight all search matches |
| `incsearch` | `true` | Show matches incrementally while typing |

### Performance Options
| Option | Value | Description |
|--------|-------|-------------|
| `updatetime` | `50` | Write swap/trigger events after 50ms (faster LSP updates) |

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

### Step 1: Add TreeSitter Parser (Required for Syntax Highlighting & Indentation)

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

**1c.** Restart Neovim and the parser will install automatically.

**Result:** You'll get syntax highlighting and TreeSitter-based indentation for that language.

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
