# Documentation Maintenance

Whenever you add or modify code in this repository, you **must** update the following files before considering the task complete.

---

## README.md

Update `README.md` when:
- A new plugin is added or removed → update the repository structure table and, if relevant, the Usage section.
- A new language is supported → no change needed (the "Adding a language" guide is generic).
- The installation or requirements change (e.g., a new system dependency is needed).

Do **not** bloat the README. It must stay minimal:
- Short intro + requirements + install steps
- Usage quick-reference table
- Repository structure (one line per file)
- "Adding support for a new language" section (the only in-depth section)

---

## CHEATSHEET.md

Update `CHEATSHEET.md` whenever a keymap is added, removed, or changed.

The cheatsheet is a flat set of Markdown tables grouped by topic. Each row is:

```
| `<key>` | mode | Description from the `desc` field |
```

### Adding a keymap
1. Find the correct section (Navigation, LSP, Git, etc.). Create a new section if the topic is genuinely new.
2. Add a row with the key, mode abbreviation (`n`, `v`, `x`, `i`, `o`, `n/v`, …), and the `desc` string used in `vim.keymap.set`.

### Removing a keymap
Delete the corresponding row.

### Changing a keymap
Update the key column and/or description to match the new `vim.keymap.set` call.

### Mode abbreviations used in the cheatsheet
| Abbreviation | Neovim mode |
|---|---|
| `n` | Normal |
| `v` | Visual + Select |
| `x` | Visual only |
| `i` | Insert |
| `o` | Operator-pending |
| `n/v` | Normal + Visual |
| `n/x` | Normal + Visual only |
| `o/x` | Operator-pending + Visual only |
