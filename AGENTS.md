# AGENTS.md — Neovim Configuration

Agent guidance for this repository. Load only the rule files relevant to your task.

---

## Repository Overview

Personal Neovim config written entirely in **Lua** (no VimL).
Plugin manager: **`vim.pack`** — Neovim 0.12's built-in native package manager.
Entry point: `init.lua` → `lua/config/` → `lua/plugins/` → `lua/utils/`.

```
.
├── init.lua                   # Entry point
├── nvim-pack-lock.json        # Plugin lockfile (pins git revisions)
├── .luarc.json                # lua-language-server workspace config
└── lua/
    ├── config/
    │   ├── options.lua        # vim.opt settings
    │   ├── keymaps.lua        # Leader key + global keymaps
    │   └── autocmds.lua       # Autocommands
    ├── plugins/
    │   ├── init.lua           # Loads all plugin files
    │   ├── blink-cmp.lua      # Autocompletion
    │   ├── gitsigns.lua       # Git hunk signs
    │   ├── harpoon.lua        # File bookmarks
    │   ├── kanagawa.lua       # Colorscheme
    │   ├── mininvim.lua       # mini.nvim collection
    │   ├── nvim-lspconfig.lua # LSP + Mason + conform + nvim-lint
    │   ├── nvim-treesitter.lua
    │   ├── opencode.lua       # AI agent
    │   ├── snacks.lua         # Terminal, lazygit, picker
    │   ├── telescope.lua      # Fuzzy finder
    │   ├── undotree.lua
    │   └── which-key.lua
    └── utils/
        └── statusline.lua     # Custom statusline (no plugin)
```

---

## Rule Files

Load these on demand based on the task at hand:

| File | Load when… |
|------|-----------|
| `.agents/rules/code-style.md` | writing or reviewing any Lua code |
| `.agents/rules/keymaps-autocmds.md` | adding/editing keymaps or autocommands |
| `.agents/rules/plugins.md` | adding, removing, or configuring plugins |
| `.agents/rules/tooling.md` | running formatters, linters, or diagnosing tool issues |
| `.agents/rules/git.md` | creating commits or understanding commit history |
| `.agents/rules/docs.md` | **always load** — rules for keeping README.md and CHEATSHEET.md up to date |

---

## Quick Reference

- **Reload config:** `:source $MYVIMRC` inside Neovim
- **Format a file:** `lua-format -i <file>` or `<leader>cf` in Neovim
- **No test suite.** No Makefile. No CI.
- **Never update plugins without user confirmation.** (`:pack update`)
- **After adding a plugin:** commit the updated `nvim-pack-lock.json`
- **Commit style:** `feat(scope): description` — see `.agents/rules/git.md`
