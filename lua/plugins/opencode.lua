return {
  "nickjvandyke/opencode.nvim",
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    -- Required for `snacks` provider.
    ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {}

    -- Required for `opts.events.reload`.
    vim.o.autoread = true

    -- OpenCode keymaps - consistent <leader>o prefix
    vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode…" })
    vim.keymap.set({ "n", "x" }, "<leader>om", function() require("opencode").select() end,                          { desc = "Execute opencode action…" })
    vim.keymap.set("n", "<leader>ot", function()
      -- Helper to find opencode terminal window
      local function find_opencode_win()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].filetype == "opencode_terminal" then
            return win
          end
        end
        return nil
      end
      
      local was_open = find_opencode_win() ~= nil
      require("opencode").toggle()
      
      -- If window was closed (now opening), focus it
      if not was_open then
        vim.defer_fn(function()
          local win = find_opencode_win()
          if win then
            vim.api.nvim_set_current_win(win)
          end
        end, 50) -- Small delay to let window open
      end
    end, { desc = "Toggle opencode" })

    vim.keymap.set({ "n", "x" }, "<leader>or", function() return require("opencode").operator("@this ") end,        { desc = "Add range to opencode", expr = true })
    vim.keymap.set("n",          "<leader>ol", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })

    vim.keymap.set("n", "<leader>ou", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll opencode up" })
    vim.keymap.set("n", "<leader>od", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })
    
    -- Add a convenient keymap to interrupt OpenCode from normal mode
    vim.keymap.set("n", "<leader>oi", function() require("opencode").command("session.interrupt") end, { desc = "Interrupt opencode session" })
  end,
}
