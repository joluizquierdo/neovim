# Neovim Configuration

> [!NOTE]
> TL;DR: Minimal configuration inspired by ThePrimeagen wisdom 
> to use only what's useful.

Well, here we go again, this is just another attempt to create my custom
configuration for neovim. I promised myself to stick to some community 
ready solution like [lazyvim](https://www.lazyvim.org/). And it did
the job quite well for some time. 

But in the end those distributions ship with tons of plugins
that I really don't need... and updates are sometimes a pain in the ass because
in the end things break, and even though the lazyvim team does a magnificent
work it's kind of difficult to solve and troubleshoot some of those errors 
sometimes.


Thus, following [ThePrimeagen's](https://www.youtube.com/@ThePrimeagen/videos)
advice and way of doing things, I came up with my minimal neovim setup inspired 
by their setup and wisdom.

The philosophy of this configuration is to only keep stuff that's really useful 
to boost my productivity. I don't care about fancy looking terminal and file
tree navigators, or really stylish pop-up windows.

Feel free to do whatever you like with this config, honestly
my advice for you is to create your own suited to your needs.

> [!WARNING]
> Stuff might be broken, I didn't ship a stable version yet

## 🚀 Quick Start

**Want to jump directly to all shortcuts?** → [📖 View Complete Cheatsheet](./cheatsheet/README.md)

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
│       ├── which-key.lua # Keymap helper
│       ├── telescope.lua # Fuzzy finder
│       ├── harpoon.lua   # Quick file navigation
│       ├── undotree.lua  # Undo history visualizer
│       ├── lazygit.lua   # Git integration
│       ├── gitsigns.lua  # Git signs & hunk operations
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

### 🤖 OpenCode (AI Coding Assistant)
In-editor AI assistant powered by Claude for code generation, refactoring, and questions.

**Features:**
- Ask questions about code and get context-aware responses
- Select from common actions via action menu
- Send code ranges to OpenCode for analysis
- Persistent chat history across sessions
- Context-aware suggestions using `@this` prefix

### 🍿 Snacks.nvim (UI Utilities)
Lightweight UI utilities library providing input prompts, pickers, and terminal windows. Used as backend for OpenCode plugin.

**Note:** Only input, picker, and terminal modules are enabled. This plugin runs transparently in the background.

### 🔑 Which-Key (Keymap Helper)
Shows available keybindings in a popup when you press the leader key. Helps discover commands without memorizing shortcuts.

| Keymap | Description |
|--------|-------------|
| `<leader>?` | Show buffer-local keymaps |

**Note:** Popup appears automatically after ~500ms when pressing `<Space>` (leader key). Commands are organized by category (code, diagnostics, git, harpoon, etc.)

### 🔭 Telescope (Fuzzy Finder)
Fast fuzzy finder for files, buffers, and text search using Telescope.

**Features:**
- Find files (all files or git-tracked only)
- Search through open buffers
- Grep search with interactive prompt
- Integration with LSP symbols and diagnostics

### ⚡ Blink Completion (blink.cmp)
Performant, batteries-included autocompletion plugin with fuzzy matching and multiple sources.

**Completion Sources:**
- **LSP** - Language server suggestions (functions, variables, types)
- **Path** - File system paths
- **Snippets** - Code snippets from friendly-snippets
- **Buffer** - Words from open buffers

**Features:**
- ⚡ **High performance** - Rust-based fuzzy matcher (0.5-4ms)
- 🎯 **Typo resistant** - Fuzzy matching with frequency and proximity bonus
- 📚 **Automatic documentation** - Shows popup with details and examples
- 🔧 **LSP integration** - Full LSP completion support
- 📦 **Batteries included** - Works out of the box with sensible defaults
- 🎨 **Ghost text** - Inline preview of completions

**Commands:**
- `:BlinkCmpShow` - Manually trigger completion
- `:BlinkCmpHide` - Hide completion menu
- `:BlinkCmpToggle` - Toggle completion

### 🎯 Harpoon (Quick File Navigation)
Mark and quickly navigate between frequently used files.

**Features:**
- Add current file to marks
- List all marks in Telescope
- Edit marks with interactive menu
- Jump to marks by number (1-4)
- Navigate between marks sequentially

### 🌳 LazyGit (Git Integration)
Terminal UI for git operations within Neovim. Press `?` inside LazyGit to see all available commands.

### 🔰 Gitsigns (Git Buffer Integration)
Deep git integration showing changes in the sign column and providing hunk operations.

**Features:**
- **Signs** - Visual indicators in sign column for added, changed, and deleted lines
- **Staged Signs** - Different signs for staged changes
- **Hunk Actions** - Stage, reset, and preview hunks inline or in popup
- **Blame** - Show git blame for current line or entire buffer
- **Diff** - Compare buffer with index or any revision
- **Word Diff** - Intra-line word-level diffs
- **Quickfix Integration** - Load hunks into quickfix/location list

**Commands:**
- `:Gitsigns stage_hunk` - Stage current hunk
- `:Gitsigns reset_hunk` - Reset current hunk
- `:Gitsigns preview_hunk` - Preview hunk in popup
- `:Gitsigns preview_hunk_inline` - Preview hunk inline
- `:Gitsigns blame_line` - Show blame for current line
- `:Gitsigns blame` - Show blame buffer
- `:Gitsigns diffthis [revision]` - Diff buffer against index or revision
- `:Gitsigns toggle_current_line_blame` - Toggle blame virtual text
- `:Gitsigns toggle_word_diff` - Toggle word-level diff
- `:Gitsigns setqflist` - Load hunks to quickfix

**Status Line Integration:**
- `b:gitsigns_head` - Current branch name
- `b:gitsigns_status` - Formatted status (e.g., "+3 ~2 -1")
- `b:gitsigns_status_dict` - Status dict with `added`, `removed`, `changed`, `head` keys

### 🔧 LSP (Language Server Protocol)
Provides IDE-like features: autocomplete, go-to-definition, diagnostics, refactoring, and more.

**Auto-installed servers:** lua_ls, pyright, ts_ls, gopls, rust_analyzer, terraformls, yamlls, jsonls, bashls

**Navigation (g prefix):**

| Keymap | Description |
|--------|-------------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `K` | Hover documentation |

**Code Actions (<leader>c):**

| Keymap | Description |
|--------|-------------|
| `<leader>ca` | Code action |
| `<leader>cr` | Rename symbol |
| `<leader>cd` | Show diagnostic|
| `<leader>cs` | Document symbols |
| `<leader>cw` | Workspace symbols |

**Diagnostics (<leader>d):**

| Keymap | Description |
|--------|-------------|
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

**Other:**

| Keymap | Description |
|--------|-------------|
| `<C-k>` | Signature help (insert mode) |

**Commands:**
- `:Mason` - Open Mason UI to manage LSP servers
- `:LspInfo` - Show LSP status
- `:LspInstall <server>` - Install LSP server
- `:LspRestart` - Restart LSP servers

### ⏪ Undotree (Undo History)
Visualize and navigate your undo history as a tree. Shows timestamps and change previews.

### 🌲 TreeSitter (Syntax Highlighting & Indentation)
Provides advanced syntax highlighting, language-aware auto-indentation, and code folding.

**Installed Parsers:** lua, python, go, rust, typescript, javascript, bash, zsh, html, helm, terraform, dockerfile, json, yaml, vim, vimdoc

**Features:**
- **Syntax highlighting** - Advanced, semantic syntax highlighting
- **Indentation** - Language-aware auto-indentation (use `=` to reindent)
- **Code folding** - TreeSitter-based folding for functions, classes, blocks
- Falls back to basic features for languages without parsers

**Commands:**
- `:InspectTree` - Show syntax tree for current buffer
- `:Inspect` - Show treesitter node under cursor
- `:TSInstall <lang>` - Install parser for language
- `:TSUpdate` - Update all installed parsers

### 🎨 Kanagawa (Colorscheme)
Active colorscheme. Auto-loads on startup.

### ✍️ Spell Checking
Built-in spell checking automatically enabled for markdown files (`.md`, `.markdown`).

**Features:**
- Automatically enabled for markdown files
- Supports multiple languages: English (en_us) and Spanish (es)
- Misspelled words appear underlined
- Personal dictionary stored in `~/.config/nvim/spell/`

**Manual Commands:**
- `:set spell` - Enable spell checking for current buffer
- `:set nospell` - Disable spell checking
- `:set spelllang=en_us` - Change language (en_us, es, en_gb, etc.)
- `:set spelllang=en_us,es` - Check multiple languages

**Customizing Languages:**
Edit `lua/config/options.lua` and modify the spelllang setting:
```lua
vim.opt_local.spelllang = 'en_us,es'  -- Add/remove languages as needed
```

**Available Languages:** en_us, en_gb, es, fr, de, it, pt, ru, and many more. See `:help spell` for full list.

### 📁 Code Folding
Smart code folding powered by TreeSitter syntax trees. Folds are automatically detected based on language structure (functions, classes, blocks, etc.).

**Features:**
- TreeSitter-based folding for supported languages
- Manual folding fallback for languages without parsers
- All folds open by default (`foldlevel = 99`)
- Folds preserved when switching buffers

**Configuration:**
Folding is configured in `lua/config/options.lua`. To disable, comment out or remove the `vim.api.nvim_create_autocmd` block for folding.

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

**Plugin Management:**
```vim
:Lazy               " Open lazy.nvim plugin manager UI
:Lazy sync          " Update all plugins
```

**Health Check:**
```vim
:checkhealth        " Check Neovim health
:messages           " View startup messages/errors
```

**Netrw (File Explorer):**
- `<Ctrl-L>` - Refresh file listing
- `%` - Create new file
- `d` - Create new directory
- `D` - Delete file/directory
- `-` - Go up one directory

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
