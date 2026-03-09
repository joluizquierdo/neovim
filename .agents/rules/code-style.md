# Code Style

## Language
- Pure Lua (LuaJIT-compatible). No VimL / `.vim` files.
- Target Neovim 0.12+ APIs.
- No classes or metatables. Keep code flat and procedural.

## Indentation & Formatting
- 4-space indentation, `expandtab` (no literal tabs).
- No trailing whitespace (`mini.trailspace` strips it at runtime).
- Blank lines between logical sections.
- Section separators in long files:
  ```lua
  -- =========================================
  -- Configure mason (LSP installer)
  -- =========================================
  ```

## String Quotes
Mixed `'...'` and `"..."` — no enforced rule. Match the style already present in the file you are editing.

## Imports (`require`)
1. Assign to a local when the module's API is called:
   ```lua
   local conform = require("conform")
   local builtin = require("telescope.builtin")
   ```
2. Inline inside a function for lazily-accessed modules:
   ```lua
   vim.keymap.set("n", "<leader>ld", function()
       require("telescope.builtin").lsp_definitions()
   end, opts)
   ```
3. No assignment when loading for side-effects only (e.g., `require("plugins.kanagawa")`).
4. All top-level `require` calls go at the top of the file, before any logic.

## Naming Conventions
| Entity           | Convention   | Example                        |
|------------------|--------------|--------------------------------|
| Local variables  | `snake_case` | `lsp_on_attach`, `lint_augroup`|
| Local functions  | `snake_case` | `get_mode()`, `get_git_branch()`|
| Global functions | `PascalCase` | `Statusline()` (vimscript interop only) |
| Augroup names    | `"PascalCase"` string | `"UserConfig"`, `"LspAttach"` |
| Plugin spec keys | match plugin README | `formatters_by_ft` |

Never introduce globals unless required for `v:lua.*` interop.

## Error Handling
- `pcall` for calls that may fail at startup or in autocommand callbacks:
  ```lua
  pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
  ```
- Guard-clause / early-return instead of deep nesting:
  ```lua
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  if not client then
      vim.notify("LSP not attached", vim.log.levels.WARN)
      return
  end
  ```
- `vim.notify` with explicit log level for user-visible messages:
  ```lua
  vim.notify("msg", vim.log.levels.WARN)
  vim.notify("msg", vim.log.levels.ERROR)
  ```
- No bare `error()` or `assert()` in config files — silent/graceful failures preferred over crashing startup.
