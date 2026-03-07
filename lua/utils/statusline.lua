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

-- Helper function to format the file name and its status
local function get_file_info()
    local filename = vim.fn.expand('%:t') -- Get just the file name
    if filename == "" then
        filename = "👻 [No Name]"
    else
        filename = "📄 " .. filename
    end

    local modified = vim.bo.modified and " 💾" or ""
    local readonly = vim.bo.readonly and " 🔒" or ""

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

