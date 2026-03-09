# Plugin System

## Plugin Manager: `vim.pack`
Neovim's built-in package manager (0.12+). No third-party manager (no lazy.nvim, packer, etc.).

```lua
-- Add a plugin at the top of its config file:
vim.pack.add({
    src     = "github.com/author/plugin.nvim",
    version = "v1.x",   -- optional tag/branch
})
```

The lockfile `nvim-pack-lock.json` pins each plugin to a specific git `rev`.
After adding or updating a plugin, commit the updated lockfile.

> **Never update plugins without user confirmation.**
> To update inside Neovim: `:pack update` (all) or `:pack update <name>` (single).

## Plugin File Structure (`lua/plugins/*.lua`)
Each file follows four ordered sections:
```lua
-- 1. Declare the plugin
vim.pack.add({ src = "github.com/author/plugin.nvim", version = "v1.x" })

-- 2. Require needed modules
local plugin = require("plugin")

-- 3. Setup / configure
plugin.setup({ ... })

-- 4. Keymaps (if any)
vim.keymap.set(...)
```

## Active Plugins
| File | Plugin(s) | Purpose |
|------|-----------|---------|
| `blink-cmp.lua` | blink.cmp v1.9.1 | Autocompletion |
| `gitsigns.lua` | gitsigns.nvim | Git hunk signs |
| `harpoon.lua` | harpoon (harpoon2) | File bookmarks |
| `kanagawa.lua` | kanagawa.nvim | Colorscheme |
| `mininvim.lua` | mini.nvim | ai, surround, pairs, comment, trailspace |
| `nvim-lspconfig.lua` | nvim-lspconfig + mason + conform.nvim + nvim-lint | LSP, format, lint |
| `nvim-treesitter.lua` | nvim-treesitter | Highlight, indent, fold |
| `opencode.lua` | opencode.nvim | AI coding agent |
| `snacks.lua` | snacks.nvim | Terminal, lazygit, picker |
| `telescope.lua` | telescope.nvim + fzf-native | Fuzzy finder |
| `undotree.lua` | undotree | Undo history |
| `which-key.lua` | which-key.nvim | Keymap hints |
