# Neovim Configuration

> [!NOTE]
> TL;DR: Neovim minimal configuration to only use what's really useful to my
> workflow.
>
> Update: With Neovim 0.12+ I ditched lazy.nvim plugin manager and
> I've started using the builtin package manager.

Well, here we go again, this is just another attempt to create my custom
configuration for Neovim. I promised myself to stick to some community
ready solution like [lazyvim](https://www.lazyvim.org/) to avoid
expending my life an energy debugging my editor config every time
I updated anything.

And it did the job quite well for some time...

However, those distributions also ship with a bunch of plugins (LazyVim
shipped with 34 plugins), whose many of them I don't really need. Plus,
sometimes that amount of unnecessary plugins break, and good luck if you
wanted to add something new yourself, as you will need to
reconcile those 34 plugins that you don't know what they are doing with your
custom feature... Therefore, after some time I found myself in step 0 again
expending a lot of time trying to make my editor work.

I've focused in a third approach:

**Keep config as minimal as possible** so:
- You are fully aware of what's going on in your editor.
- Risk of plugins conflicting and config headaches are minimized.
- Maintenance time is greatly reduce.
- You can sleep at night.

Therefore, I don't care about a fancy looking terminal and file
tree navigators, or really stylish pop-up windows, I'll try to use as much as
Neovim builtin features as possible.

Feel free to do whatever you like with this config.
But if you want my honest advice, you should learn
the basic concepts of lua and Neovim and create your own custom config
suited to your need, maybe using this one as an inspiration. That, way
you'll be able to manage this epic editor consistently without loosing your
head.

> [!WARNING]
> Stuff might be broken, I didn't ship a stable version yet

## Special Thanks

- Thanks to Neovim and all the amazing community, that supports it.
- Thanks to [ThePrimeagen](https://www.youtube.com/@ThePrimeagen/videos),
the philosophy and this configuration is inspired by his content.
- Thanks to [@theradlectures](https://www.youtube.com/@theradlectures) for
his nice guide about Neovim setup in 2026 and explaining the virtues of Neovim
0.12. Thanks to him I removed Lazy.nvim package manager.

## Requirements

### Always required

- **Neovim 0.12+**
- **`git`** — plugin manager fetches plugins via git
- **`luarocks` - A lua package manager
- **`ripgrep` (`rg`)** — Telescope uses it for `find_files` and `live_grep`
- **`make` + a C compiler (`gcc` or `clang`)** — needed to compile the `telescope-fzf-native` C extension on first install/update
- **A Nerd Font** — `blink.cmp` and `mini.icons` render glyphs from a Nerd Font; install one (e.g. [JetBrainsMono Nerd Font](https://www.nerdfonts.com/)) and set it in your terminal emulator
- **`lazygit`** — For git management
- **`opencode`** - AI agent integrated into Neovim
- **`Node.js`** — required at runtime by `bashls` and `ts_ls`; install via `nvm` or your system package manager.

> [!IMPORTANT]
> Don't forget to use `:checkhealth` to check that there's no errors in your
> Neovim installation

### Language tooling (external)

> [!NOTE]
> Mason manages LSP, formatters and linters.
> However, I recommend using mason to exclusively install LSPs. Mason don't
> expose those utilities to the shell `$PATH`. And some of them can't be
> automatically install, and you will require to use `:MasonInstall <linter>`
> Therefore, formatters and linters should be installed
> externally to be available on `$PATH` (or as project-local `node_modules/.bin`
> binaries for npm tools).

| Tool | Purpose | Install |
|------|---------|---------|
| `stylua` | Lua formatter | `brew install stylua` or `cargo install stylua` |
| `prettier` | JS/TS formatter | `brew install prettier` or `npm i -g prettier` or `npm i -D prettier` |
| `eslint` | JS/TS linter | `npm i -g eslint` or `npm i -D eslint` |
| `opentofu` | Terraform formatter (`tofu_fmt`) | `brew install opentofu` |
| `tflint` | Terraform linter | `brew install tflint` |
| `tfsec` | Terraform security linter | `brew install tfsec` |

## Installation

```bash
git clone git@github.com:joluizquierdo/neovim.git ~/.config/nvim
nvim   # plugins are fetched automatically on first launch
```

On first launch Neovim will download all plugins declared in `lua/plugins/`.
Run `:pack update` at any time to update plugins to their latest revisions.

## Usage

| Action | How |
|--------|-----|
| See all keymaps | `<Space>?` (which-key, buffer-local) |
| Full cheatsheet | see [CHEATSHEET.md](CHEATSHEET.md) |
| Format current file | `<Space>cf` |
| Toggle format on save | `<Space>tf` |
| Open file tree | `<Space>pv` |
| Fuzzy find files | `<Space>pf` |
| Open LazyGit | `<Space>gg` |
| Open AI agent | `<Space>ot` |

Leader key is `<Space>`.

---

## Languages

Languages are supported through a combination of Treesitter (syntax highlighting, indentation, folding), LSP (diagnostics, go-to-definition, etc.), formatters (conform.nvim), and linters (nvim-lint).

| Language | Treesitter | LSP | Formatter | Linter |
|----------|-----------|-----|-----------|--------|
| Lua | ✓ | `lua_ls` | `stylua` | — |
| Rust | ✓ | `rust_analyzer` | — | — |
| Go | ✓ | — | — | — |
| Python | ✓ | — | — | — |
| Bash | ✓ | `bashls` | — | — |
| Zsh | ✓ | — | — | — |
| TypeScript / JavaScript | ✓ | `ts_ls` | `prettier` | `eslint` |
| HTML | ✓ | — | — | — |
| JSON | ✓ | `jsonls` | — | — |
| YAML | ✓ | `yamlls` | — | — |
| Helm / Go templates | ✓ | `helm_ls` | — | — |
| Terraform / OpenTofu | ✓ | `tofu_ls` | `tofu_fmt` | `tflint`, `tfsec` |
| Dockerfile | ✓ | — | — | — |
| Vim / Vimdoc | ✓ | — | — | — |

---

## Repository Structure

```
.
├── init.lua                   # Entry point — loads config and plugins in order
├── nvim-pack-lock.json        # Lockfile: pins every plugin to a specific git revision
├── .luarc.json                # lua-language-server workspace configuration
├── after/
│   └── ftplugin/
│       ├── helm.lua           # 2-space indent override for Helm
│       ├── javascript.lua     # 2-space indent override for JavaScript
│       ├── lua.lua            # 2-space indent override for Lua
│       └── typescript.lua     # 2-space indent override for TypeScript
└── lua/
    ├── config/
    │   ├── options.lua        # Editor settings (tabs, line numbers, search, etc.)
    │   ├── keymaps.lua        # Global keymaps and leader key definition
    │   └── autocmds.lua       # Autocommands (yank highlight, cursor restore, etc.)
    └── plugins/
        ├── init.lua           # Requires every plugin file in load order
        ├── blink-cmp.lua      # Autocompletion (blink.cmp)
        ├── gitsigns.lua       # Git hunk indicators in the sign column
        ├── harpoon.lua        # File bookmarks (harpoon2)
        ├── kanagawa.lua       # Colorscheme
        ├── lualine.lua        # Status line (lualine.nvim + nvim-web-devicons)
        ├── mininvim.lua       # mini.nvim: ai, surround, pairs, comment, trailspace, notify, icons
        ├── nvim-lspconfig.lua # LSP client config + Mason installer + conform.nvim + nvim-lint
        ├── nvim-treesitter.lua# Syntax highlighting, indentation, and folding
        ├── opencode.lua       # AI coding agent (opencode.nvim)
        ├── snacks.lua         # Terminal, LazyGit overlay, input, picker
        ├── telescope.lua      # Fuzzy finder
        ├── undotree.lua       # Visual undo history
        └── which-key.lua      # Keymap discovery popup
```

---

## Adding Support for a New Language

Adding a language requires three steps: Treesitter grammar, LSP server, and (optionally) a formatter/linter.

### 1. Treesitter grammar

Open `lua/plugins/nvim-treesitter.lua` and add the language name to the `ensure_installed` list:

```lua
require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "lua", "bash", "rust",
        "go",  -- <-- add here
    },
    ...
})
```

Neovim will download and compile the grammar on next startup.

### 2. LSP server

Open `lua/plugins/nvim-lspconfig.lua` and add the Mason server name to `ensure_installed`:

> [!NOTE]
> use :Mason to see an UI for listing/installing LSP, formatters, linters...

```lua
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "gopls",  -- <-- add here
    },
})
```

Then register the server with `nvim-lspconfig` in the same file.
Most servers work with zero config:

```lua
require("lspconfig").gopls.setup({})
```

For servers that need options, pass them explicitly:

```lua
require("lspconfig").gopls.setup({
    settings = {
        gopls = { analyses = { unusedparams = true } },
    },
})
```
### 3. Formatter (conform.nvim)

In `lua/plugins/nvim-lspconfig.lua`, add the filetype → formatter mapping:

```lua
conform.setup({
    formatters_by_ft = {
        lua       = { "luaformatter" },
        go        = { "gofmt" },  -- <-- add here
    },
})
```

If the formatter is available through Mason, install it with `:MasonInstall <name>`.
Otherwise install it system-wide and ensure the binary is in `$PATH`.

### 4. Linter (nvim-lint) — optional

In `lua/plugins/nvim-lspconfig.lua`, add the filetype → linter mapping:

```lua
lint.linters_by_ft = {
    terraform = { "tflint" },
    go        = { "golangci-lint" },  -- <-- add here
}
```

> [!NOTE]
> You will require to have the linter installed with Mason or externally
