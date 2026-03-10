# Cheatsheet

Leader key: `<Space>`

## Navigation & Files

| Key | Mode | Description |
|-----|------|-------------|
| `<Space>pv` | n | Open file tree (netrw) |
| `<Space>pf` | n | Telescope: find files |
| `<Space>pb` | n | Telescope: open buffers |
| `<Space>pg` | n | Telescope: git-tracked files |
| `<Space>pl` | n | Telescope: live grep |
| `<Space>ps` | n | Telescope: grep string (prompt) |
| `<Space>?`  | n | which-key: show buffer-local keymaps |

## Motion

| Key | Mode | Description |
|-----|------|-------------|
| `h` `j` `k` `l` | n/v | Left / down / up / right |
| `w` / `b` | n/v | Next / previous word (start) |
| `e` / `ge` | n/v | Next / previous word (end) |
| `W` / `B` / `E` | n/v | Same as above but WORD (whitespace-delimited) |
| `0` / `^` / `$` | n/v | Start of line / first non-blank / end of line |
| `gg` / `G` | n/v | First / last line of file |
| `{` / `}` | n/v | Previous / next empty line (paragraph) |
| `%` | n/v | Jump to matching bracket/paren |
| `<C-d>` | n | Scroll half-page down, cursor centred |
| `<C-u>` | n | Scroll half-page up, cursor centred |
| `<C-f>` / `<C-b>` | n | Scroll full page forward / backward |
| `zz` / `zt` / `zb` | n | Centre / top / bottom current line in window |
| `H` / `M` / `L` | n | Jump to top / middle / bottom of visible window |
| `f<char>` / `F<char>` | n/v | Jump to next / previous `<char>` on line |
| `t<char>` / `T<char>` | n/v | Jump before next / previous `<char>` on line |
| `;` / `,` | n/v | Repeat / reverse last `f/F/t/T` |
| `''` or ` `` ` | n | Jump back to position before last jump |
| `<C-o>` / `<C-i>` | n | Older / newer position in jump list |
| `gd` (no LSP) | n | Go to local definition |
| `*` / `#` | n | Search word under cursor forward / backward |
| `n` / `N` | n | Next / prev search match, centred |

## Editing

| Key | Mode | Description |
|-----|------|-------------|
| `i` / `a` | n | Insert before / after cursor |
| `I` / `A` | n | Insert at start / end of line |
| `o` / `O` | n | Open new line below / above |
| `s` / `S` | n | Substitute character / line |
| `r<char>` | n | Replace character under cursor |
| `~` | n | Toggle case of character |
| `u` / `<C-r>` | n | Undo / redo |
| `.` | n | Repeat last change |
| `x` / `X` | n | Delete character forward / backward |
| `dd` / `D` | n | Delete line / to end of line |
| `cc` / `C` | n | Change line / to end of line |
| `yy` / `Y` | n | Yank line |
| `p` / `P` | n | Paste after / before cursor |
| `>>` / `<<` | n | Indent / dedent line |
| `>` / `<` | v | Indent / dedent selection |
| `=` | v | Auto-indent selection |
| `J` | n | Join line below (cursor stays put) |
| `J` | v | Move selected lines down |
| `K` | v | Move selected lines up |
| `<Space>p` | x | Paste over selection without yanking |
| `<Space>y` | n/v | Yank to system clipboard |
| `<Space>Y` | n | Yank line to system clipboard |
| `<Space>D` | n/v | Delete without overwriting register |
| `<C-c>` | i | Escape to normal mode |
| `<C-s>` | n | Save current file (force) |
| `<Space>s` | n | Replace word under cursor (file-wide) |
| `<Space>x` | n | Make current file executable |
| `<Space>bd` | n | Delete buffer, keep window |
| `<Space>qq` | n | Quit all windows |
| `Q` | n | Disabled (no-op) |

## Text Objects

| Key | Mode | Description |
|-----|------|-------------|
| `iw` / `aw` | o/x | Inner / around word |
| `iW` / `aW` | o/x | Inner / around WORD |
| `is` / `as` | o/x | Inner / around sentence |
| `ip` / `ap` | o/x | Inner / around paragraph |
| `i(` / `a(` | o/x | Inner / around parentheses (also `ib`/`ab`) |
| `i[` / `a[` | o/x | Inner / around brackets |
| `i{` / `a{` | o/x | Inner / around braces (also `iB`/`aB`) |
| `i"` / `a"` | o/x | Inner / around double quotes |
| `i'` / `a'` | o/x | Inner / around single quotes |
| `` i` `` / `` a` `` | o/x | Inner / around backticks |
| `it` / `at` | o/x | Inner / around HTML/XML tag |
| `ig` | o/x | Select git hunk (gitsigns) |

## Visual Mode

| Key | Mode | Description |
|-----|------|-------------|
| `v` / `V` / `<C-v>` | n | Character / line / block visual mode |
| `gv` | n | Re-select last visual selection |
| `o` | v | Move cursor to other end of selection |
| `u` / `U` | x | Lowercase / uppercase selection |

## Windows & Tabs

| Key | Mode | Description |
|-----|------|-------------|
| `<C-w>s` / `<C-w>v` | n | Split window horizontal / vertical |
| `<C-w>h/j/k/l` | n | Move focus to left/down/up/right window |
| `<C-w>H/J/K/L` | n | Move window to far left/down/up/right |
| `<C-w>=` | n | Equalise window sizes |
| `<C-w>q` | n | Close current window |
| `<C-w>o` | n | Close all windows except current |
| `<C-w>+` / `<C-w>-` | n | Increase / decrease window height |
| `<C-w>>` / `<C-w><` | n | Increase / decrease window width |
| `gt` / `gT` | n | Next / previous tab |
| `:tabnew` | — | Open new tab |

## Folds

| Key | Mode | Description |
|-----|------|-------------|
| `za` | n | Toggle fold under cursor |
| `zo` / `zc` | n | Open / close fold |
| `zR` / `zM` | n | Open all / close all folds |
| `zj` / `zk` | n | Move to next / previous fold |

## Marks & Registers

| Key | Mode | Description |
|-----|------|-------------|
| `m<letter>` | n | Set mark at cursor |
| `'<letter>` | n | Jump to mark line |
| `` `<letter> `` | n | Jump to mark exact position |
| `"<register>` | n | Use named register for next yank/delete/paste |
| `"0p` | n | Paste from yank register (survives deletions) |
| `"+p` / `"*p` | n | Paste from system / selection clipboard |
| `:reg` | — | List all registers |

## Macros

| Key | Mode | Description |
|-----|------|-------------|
| `q<letter>` | n | Start recording macro into register |
| `q` | n | Stop recording |
| `@<letter>` | n | Play macro |
| `@@` | n | Repeat last played macro |
| `<number>@<letter>` | n | Play macro N times |

## Command Line

| Key | Mode | Description |
|-----|------|-------------|
| `:` | n | Enter command mode |
| `/` / `?` | n | Search forward / backward |
| `<C-r><C-w>` | c | Insert word under cursor into command line |
| `<Up>` / `<Down>` | c | Navigate command history |
| `q:` | n | Open command history window |
| `q/` | n | Open search history window |

## Surround (mini.surround)

| Key | Mode | Description |
|-----|------|-------------|
| `ys<motion><char>` | n | Add surrounding |
| `yss<char>` | n | Surround current line |
| `S<char>` | x | Surround visual selection |
| `ds<char>` | n | Delete surrounding |
| `cs<old><new>` | n | Change surrounding |

## LSP

| Key | Mode | Description |
|-----|------|-------------|
| `gd` | n | Go to declaration |
| `gD` | n | Go to definition |
| `gS` | n | Go to definition in vertical split |
| `K` | n | Hover documentation |
| `<C-k>` | n | Signature help |
| `<Space>ca` | n | Code action |
| `<Space>cr` | n | Rename symbol |
| `<Space>co` | n | Organize imports |
| `<Space>cf` | n/v | Format buffer (conform.nvim) |
| `<Space>ld` | n | LSP: definitions (Telescope) |
| `<Space>lr` | n | LSP: references (Telescope) |
| `<Space>lt` | n | LSP: type definitions (Telescope) |
| `<Space>ls` | n | LSP: document symbols (Telescope) |
| `<Space>lw` | n | LSP: workspace symbols (Telescope) |
| `<Space>li` | n | LSP: implementations (Telescope) |

## Diagnostics

| Key | Mode | Description |
|-----|------|-------------|
| `]d` | n | Jump to next diagnostic |
| `[d` | n | Jump to previous diagnostic |
| `<Space>dd` | n | Show line diagnostics (float) |
| `<Space>dc` | n | Show cursor diagnostics (float) |
| `<Space>dl` | n | Open diagnostic list (loclist) |

## Git (gitsigns)

| Key | Mode | Description |
|-----|------|-------------|
| `]h` | n | Next git hunk |
| `[h` | n | Previous git hunk |
| `<Space>gi` | n | Preview hunk inline |
| `<Space>gs` | n | Stage hunk |
| `<Space>gr` | n | Reset hunk |
| `<Space>gS` | n | Stage buffer |
| `<Space>gR` | n | Reset buffer |
| `<Space>gb` | n | Blame current line |
| `<Space>gl` | n | Blame current line (alias) |
| `<Space>gd` | n | Diff against last commit |
| `<Space>gg` | n | Open LazyGit |
| `ig` | o/x | Text object: select git hunk |

## Toggles

| Key | Mode | Description |
|-----|------|-------------|
| `<Space>tb` | n | Toggle inline git blame |
| `<Space>tw` | n | Toggle word diff |
| `<Space>tg` | n | Toggle git signs |
| `<Space>tf` | n | Toggle format on save (current buffer) |
| `<Space>u`  | n | Toggle undotree |

## Harpoon

| Key | Mode | Description |
|-----|------|-------------|
| `<Space>ha` | n | Add current file to harpoon list |
| `<Space>he` | n | Edit harpoon list (quick menu) |
| `<Space>hl` | n | List harpoon files in Telescope |
| `<Space>1`–`6` | n | Jump to harpoon file 1–6 |
| `<Space>hp` | n | Harpoon: previous file |
| `<Space>hn` | n | Harpoon: next file |

## AI (opencode.nvim)

| Key | Mode | Description |
|-----|------|-------------|
| `<Space>ot` | n | Toggle opencode panel |
| `<Space>oa` | n/x | Ask opencode (sends selection/context) |
| `<Space>om` | n/x | Select opencode action |
| `<Space>or` | n/x | Add range to opencode (operator) |
| `<Space>ol` | n | Add current line to opencode |
| `<Space>ou` | n | Scroll opencode panel up |
| `<Space>od` | n | Scroll opencode panel down |
| `<Space>oi` | n | Interrupt opencode session |
