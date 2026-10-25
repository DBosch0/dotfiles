-- Shared settings used by more than one config file.
-- Load with: local vars = require("configs/vars")

local M = {}

-- Programs
M.terminal    = "ghostty"
M.fileManager = "fish -c y" -- yazi, launched through the fish `y` wrapper
M.menu        = "rofi -show drun"
M.browser     = "librewolf"

M.mainMod = "SUPER"

-- pywal colors. pywal writes ~/.cache/wal/colors.lua as a table of "#rrggbb" strings.
-- Hyprland wants "rgb(rrggbb)", so convert them. Fall back to defaults if wal hasn't run.
local fallback = { color0 = "#100a17", color4 = "#33ccff", color6 = "#a99fa1", color7 = "#c3c1c5" }
local ok, wal = pcall(dofile, os.getenv("HOME") .. "/.cache/wal/colors.lua")
if not ok or type(wal) ~= "table" then
    wal = fallback
end

M.colors = {}
for name, value in pairs(wal) do
    if type(value) == "string" and value:match("^#%x%x%x%x%x%x$") then
        M.colors[name] = "rgb(" .. value:sub(2) .. ")"
    end
end

return M
