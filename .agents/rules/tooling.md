# Tooling & Commands

## Reloading Config
There is no build step. To apply changes:
```
# Inside Neovim:
:source $MYVIMRC

# Or restart Neovim entirely.
```

## Formatting
- **Formatter:** `luaformatter` (via `conform.nvim`, triggered with `<leader>cf`)
- **Shell usage** (single file):
  ```bash
  lua-format -i lua/plugins/nvim-lspconfig.lua
  ```
- No `.stylua.toml` or `.luacheck` config files are present.

## Linting
- **Lua:** `lua-language-server` (LuaLS) for static analysis — config in `.luarc.json`.
- **Terraform:** `tflint` via `nvim-lint` (triggers on `BufEnter`, `BufWritePost`, `InsertLeave`).
- No linter runs from the shell; all linting is in-editor.

## Tests
No test framework is configured (no busted, plenary test runner, mini.test, etc.).
There is no command to run tests.

## LuaLS Config (`.luarc.json`)
```json
{
  "runtime.version": "LuaJIT",
  "runtime.path": ["lua/?.lua", "lua/?/init.lua"],
  "diagnostics.globals": ["vim"],
  "workspace.library": ["$VIMRUNTIME", "${3rd}/luv/library"],
  "workspace.checkThirdParty": false
}
```
- `vim` is declared as a known global — do not suppress with `---@diagnostic disable`.
- Add new globals to `diagnostics.globals` only when absolutely necessary.
