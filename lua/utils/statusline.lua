-- Helper function to get the current Vim mode
local function get_mode()
    local modes = {
        n  = "🟢 N",
        i  = "🔵 I",
        v  = "🟣 V",
        V  = "🟣 V-L",
        ["\22"] = "🟣 V-B", -- ^V (Visual Block)
        c  = "🟠 CMD",
        t  = "🔴 TRM",
        R  = "🔴 RPLC",
    }
    local current_mode = vim.api.nvim_get_mode().mode
    return modes[current_mode] or ("⚪ " .. current_mode)
end

local function get_git_branch()
    -- Run the Git CLI command and capture the output as a list of lines
    local output = vim.fn.systemlist("git branch --show-current 2> /dev/null")

    -- Return empty string if not in a git repo (error) or if output is empty
    if vim.v.shell_error ~= 0 or #output == 0 or output[1] == "" then
        return ""
    end

    return "🌱 " .. output[1]
end

local function get_file_info()
    -- 1. Get the window ID being drawn (fallback to current window if nil)
    local winid = vim.g.statusline_winid or vim.api.nvim_get_current_win()

    -- 2. Get the buffer associated with that window
    local bufnr = vim.api.nvim_win_get_buf(winid)

    -- 3. Get the full file path and extract just the tail (filename)
    local filepath = vim.api.nvim_buf_get_name(bufnr)
    local filename = vim.fn.fnamemodify(filepath, ':t')

    if filename == "" then
        filename = "👻 [No Name]"
    else
        filename = "📄 " .. filename
    end

    -- 4. Check modified and readonly states for this specific buffer
    local modified = vim.bo[bufnr].modified and " 💾" or ""
    local readonly = vim.bo[bufnr].readonly and " 🔒" or ""

    return filename .. modified .. readonly
end

-- Helper function for cursor position (line and column)
local function get_position()
    return "📍 %l:%c"
end

-- Main statusline builder function (Must be global for v:lua to access it)
function Statusline()
    local mode = get_mode()
    local git = get_git_branch()
    local file = get_file_info()
    local pos = get_position()

    -- Combine the left side
    local left_components = { mode }
    if git ~= "" then table.insert(left_components, git) end
    table.insert(left_components, file)

    local left = table.concat(left_components, " │ ")

    -- Right side
    local right = pos

    -- Combine with '%=' which pushes the right side to the edge of the window
    return " " .. left .. " %= " .. right .. " "
end

-- Assign the statusline to call our global Lua function
vim.opt.statusline = "%!v:lua.Statusline()"

