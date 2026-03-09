# Keymaps & Autocommands

## Keymaps
All keymaps must include a `desc` field so they appear in which-key:
```lua
vim.keymap.set("n", "<leader>cf", function()
    require("conform").format({ async = true })
end, { desc = "Format buffer" })
```

When multiple keymaps share a base opts table, mutate `opts.desc` in place:
```lua
local opts = { noremap = true, silent = true, buffer = bufnr }
opts.desc = "Go to declaration"
vim.keymap.set("n", "gd", vim.lsp.buf.declaration, opts)
opts.desc = "Go to definition"
vim.keymap.set("n", "gD", vim.lsp.buf.definition, opts)
```

## Autocommands
Always use a named `augroup` with `{ clear = true }` to prevent duplication on re-source:
```lua
local augroup = vim.api.nvim_create_augroup("MyGroup", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
    group = augroup,
    callback = function() ... end,
})
```
