# Neovim Configuration Cheatsheet

Quick reference for all keybindings and shortcuts in this configuration.

**Leader Key:** `Space`

---

## 🗺️ Complete Keybindings Reference

### 🤖 AI & Code Intelligence

| Keymap | Mode | Description | Source |
|--------|------|-------------|--------|
| `<leader>oa` | Normal, Visual | Ask OpenCode (with current context) | OpenCode |
| `<leader>om` | Normal, Visual | Execute OpenCode action menu | OpenCode |
| `<leader>ot` | Normal, Terminal | Toggle OpenCode panel | OpenCode |
| `<leader>or` | Normal, Visual | Add range to OpenCode | OpenCode |
| `<leader>ol` | Normal | Add current line to OpenCode | OpenCode |
| `<leader>ou` | Normal | Scroll OpenCode panel up | OpenCode |
| `<leader>od` | Normal | Scroll OpenCode panel down | OpenCode |

### 🔧 LSP (Language Server Protocol)

| Keymap | Mode | Description | Source |
|--------|------|-------------|--------|
| `gd` | Normal | Go to definition | LSP |
| `gD` | Normal | Go to declaration | LSP |
| `gr` | Normal | Go to references | LSP |
| `gI` | Normal | Go to implementation | LSP |
| `<leader>ca` | Normal | Code action | LSP |
| `<leader>cr` | Normal | Rename symbol | LSP |
| `<leader>cd` | Normal | Show diagnostic | LSP |
| `<leader>cs` | Normal | Document symbols (Telescope) | LSP |
| `<leader>cw` | Normal | Workspace symbols (Telescope) | LSP |
| `K` | Normal | Hover documentation | LSP |
| `<C-k>` | Insert | Signature help | LSP |
| `[d` | Normal | Previous diagnostic | LSP |
| `]d` | Normal | Next diagnostic | LSP |

### ⚡ Autocompletion (Blink)

| Keymap | Mode | Description | Source |
|--------|------|-------------|--------|
| `<CR>` | Insert | Accept selected completion | Blink |
| `<C-Space>` | Insert | Open completion menu / Show docs | Blink |
| `<C-n>` or `↓` | Insert | Select next item | Blink |
| `<C-p>` or `↑` | Insert | Select previous item | Blink |
| `<C-e>` | Insert | Close completion menu | Blink |
| `<C-k>` | Insert | Toggle signature help | Blink |

### 🔭 Fuzzy Finding (Telescope)

| Keymap | Mode | Description | Source |
|--------|------|-------------|--------|
| `<leader>pf` | Normal | Find files (all files) | Telescope |
| `<leader>pb` | Normal | Find buffers | Telescope |
| `<C-p>` | Normal | Find git tracked files | Telescope |
| `<leader>ps` | Normal | Grep search (prompt for term) | Telescope |

### 🎯 Quick File Navigation (Harpoon)

| Keymap | Mode | Description | Source |
|--------|------|-------------|--------|
| `<leader>ha` | Normal | Add current file to Harpoon | Harpoon |
| `<leader>hl` | Normal | List Harpoon marks (Telescope) | Harpoon |
| `<leader>he` | Normal | Edit Harpoon marks (manage menu) | Harpoon |
| `<leader>1` | Normal | Jump to Harpoon file 1 | Harpoon |
| `<leader>2` | Normal | Jump to Harpoon file 2 | Harpoon |
| `<leader>3` | Normal | Jump to Harpoon file 3 | Harpoon |
| `<leader>4` | Normal | Jump to Harpoon file 4 | Harpoon |
| `<leader>hp` | Normal | Previous Harpoon file | Harpoon |
| `<leader>hn` | Normal | Next Harpoon file | Harpoon |

### 🌳 Git Operations (LazyGit)

| Keymap | Mode | Description | Source |
|--------|------|-------------|--------|
| `<leader>gg` | Normal | Open LazyGit | LazyGit |

### 🔰 Git Signs & Hunks (Gitsigns)

| Keymap | Mode | Description | Source |
|--------|------|-------------|--------|
| `]c` | Normal | Next git hunk | Gitsigns |
| `[c` | Normal | Previous git hunk | Gitsigns |
| `<leader>gs` | Normal, Visual | Stage hunk | Gitsigns |
| `<leader>gr` | Normal, Visual | Reset hunk | Gitsigns |
| `<leader>gS` | Normal | Stage buffer | Gitsigns |
| `<leader>gR` | Normal | Reset buffer | Gitsigns |
| `<leader>gu` | Normal | Undo stage hunk | Gitsigns |
| `<leader>gp` | Normal | Preview hunk (popup) | Gitsigns |
| `<leader>gi` | Normal | Preview hunk inline | Gitsigns |
| `<leader>gb` | Normal | Blame line | Gitsigns |
| `<leader>gd` | Normal | Diff this | Gitsigns |
| `<leader>gD` | Normal | Diff against last commit | Gitsigns |
| `<leader>gQ` | Normal | Load all hunks to quickfix | Gitsigns |
| `<leader>gq` | Normal | Load hunks to quickfix | Gitsigns |
| `<leader>tb` | Normal | Toggle git blame | Gitsigns |
| `<leader>tw` | Normal | Toggle word diff | Gitsigns |
| `<leader>tg` | Normal | Toggle git signs | Gitsigns |
| `ig` | Operator, Visual | Select git hunk | Gitsigns |

### 🔑 Keymap Discovery (Which-Key)

| Keymap | Mode | Description | Source |
|--------|------|-------------|--------|
| `<leader>?` | Normal | Show buffer-local keymaps | Which-Key |
| `<leader>` (wait) | Normal | Show all leader key commands | Which-Key |

### ⏪ Undo History (Undotree)

| Keymap | Mode | Description | Source |
|--------|------|-------------|--------|
| `<leader>u` | Normal | Toggle undotree panel | Undotree |

### 📂 Navigation & Window Management

| Keymap | Mode | Description | Source |
|--------|------|-------------|--------|
| `<leader>pv` | Normal | Open file explorer (netrw) | Custom |
| `<leader>qq` | Normal | Quit all windows | Custom |

### ✏️ Moving & Editing Text

| Keymap | Mode | Description | Source |
|--------|------|-------------|--------|
| `J` | Visual | Move selected lines down | Custom |
| `K` | Visual | Move selected lines up | Custom |
| `J` | Normal | Join line below, keep cursor | Custom |
| `<C-d>` | Normal | Half-page down, cursor centered | Custom |
| `<C-u>` | Normal | Half-page up, cursor centered | Custom |
| `n` | Normal | Next search, cursor centered | Custom |
| `N` | Normal | Previous search, cursor centered | Custom |

### 📋 Clipboard & Registers

| Keymap | Mode | Description | Source |
|--------|------|-------------|--------|
| `<leader>y` | Normal, Visual | Yank to system clipboard | Custom |
| `<leader>Y` | Normal | Yank line to system clipboard | Custom |
| `<leader>p` | Visual | Paste without losing clipboard | Custom |
| `<leader>d` | Normal, Visual | Delete without saving to clipboard | Custom |

### 🔍 Find & Replace

| Keymap | Mode | Description | Source |
|--------|------|-------------|--------|
| `<leader>s` | Normal | Find & replace word under cursor | Custom |

### 🛠️ Utility

| Keymap | Mode | Description | Source |
|--------|------|-------------|--------|
| `<C-c>` | Insert | Exit insert mode (fixes visual-block) | Custom |
| `<leader>x` | Normal | Make current file executable | Custom |
| `Q` | Normal | Disabled (prevents Ex mode) | Custom |

### ✍️ Spell Checking (Markdown)

| Keymap | Mode | Description | Source |
|--------|------|-------------|--------|
| `z=` | Normal | Show spelling suggestions | Built-in |
| `]s` | Normal | Jump to next misspelled word | Built-in |
| `[s` | Normal | Jump to previous misspelled word | Built-in |
| `zg` | Normal | Add word to dictionary | Built-in |
| `zug` | Normal | Remove word from dictionary | Built-in |
| `zw` | Normal | Mark word as incorrect | Built-in |

### 📁 Code Folding (TreeSitter)

| Keymap | Mode | Description | Source |
|--------|------|-------------|--------|
| `za` | Normal | Toggle fold under cursor | Built-in |
| `zA` | Normal | Toggle fold recursively | Built-in |
| `zo` | Normal | Open fold under cursor | Built-in |
| `zO` | Normal | Open fold recursively | Built-in |
| `zc` | Normal | Close fold under cursor | Built-in |
| `zC` | Normal | Close fold recursively | Built-in |
| `zR` | Normal | Open all folds in file | Built-in |
| `zM` | Normal | Close all folds in file | Built-in |
| `zj` | Normal | Move to next fold | Built-in |
| `zk` | Normal | Move to previous fold | Built-in |

---

## 📝 Quick Tips

### Moving Lines (Visual J/K)
1. Select lines with `V` (visual-line mode)
2. Press `J` to move down or `K` to move up
3. Keeps selection active for multiple moves
4. Auto-indents moved lines

### Smart Paste (`<leader>p`)
1. Yank text with `y`
2. Select text to replace with visual mode
3. Press `<leader>p` to paste without losing yanked text
4. Useful for replacing multiple occurrences

### Find & Replace (`<leader>s`)
1. Place cursor on word to replace
2. Press `<leader>s`
3. Type replacement text and press Enter
4. Interactive - shows matches as you type

### System Clipboard (`<leader>y`)
- Works like normal `y` but copies to system clipboard
- Paste in other applications with Cmd+V (Mac) or Ctrl+V (Linux/Windows)
- Use `<leader>Y` to copy entire line

### Centered Scrolling
- `<C-d>`, `<C-u>`, `n`, `N` keep cursor in middle of screen
- Reduces eye movement and improves focus
- Especially useful when searching with `/`

### Spell Checking
- Automatically enabled for markdown files (.md, .markdown)
- Supports English and Spanish (en_us, es)
- Place cursor on misspelled word (underlined) and press `z=` for suggestions
- Use `]s` and `[s` to navigate between errors
- Add words to your personal dictionary with `zg`
- Commands: `:set spell` (enable), `:set nospell` (disable), `:set spelllang=en_us` (change language)

### Code Folding
- TreeSitter-based folding automatically enabled for supported languages
- Quick toggle: Place cursor on function/class and press `za` to fold/unfold
- Collapse all: Press `zM` to close all folds, then `za` to expand sections you need
- Expand all: Press `zR` to open everything
- Navigate: Use `zj` and `zk` to jump between foldable sections
- All folds are open by default (`foldlevel = 99`)

### Which-Key Helper
- Press `<Space>` (leader key) and pause for ~500ms to see all available commands
- Commands are organized by category with visual icons
- Press `<leader>?` to see all buffer-specific keymaps
- Great for discovering keybindings without memorizing everything

---

## 📚 Useful Commands

### Plugin Management
```vim
:Lazy               " Open lazy.nvim plugin manager UI
:Lazy sync          " Update all plugins
```

### LSP Commands
```vim
:Mason              " Open Mason UI to manage LSP servers
:LspInfo            " Show LSP status
:LspInstall <server>" Install LSP server
:LspRestart         " Restart LSP servers
```

### TreeSitter Commands
```vim
:InspectTree        " Show syntax tree for current buffer
:Inspect            " Show treesitter node under cursor
:TSInstall <lang>   " Install parser for language
:TSUpdate           " Update all installed parsers
```

### Completion Commands
```vim
:BlinkCmpShow       " Manually trigger completion
:BlinkCmpHide       " Hide completion menu
:BlinkCmpToggle     " Toggle completion
```

### Health Check
```vim
:checkhealth        " Check Neovim health
:checkhealth vim.lsp" Check LSP health specifically
:messages           " View startup messages/errors
```

### File Explorer (Netrw)
When in netrw (opened with `<leader>pv`):
- `<C-L>` - Refresh file listing
- `%` - Create new file
- `d` - Create new directory
- `D` - Delete file/directory
- `-` - Go up one directory

---

## 🔑 Keymap Legend

- `<leader>` = Space
- `<C-x>` = Ctrl + x
- `<S-x>` = Shift + x
- `<CR>` = Enter
- `↑↓` = Arrow keys
