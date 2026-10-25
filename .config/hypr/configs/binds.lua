-- Keybindings. https://wiki.hypr.land/Configuring/Basics/Binds/
-- Dispatchers: https://wiki.hypr.land/Configuring/Basics/Dispatchers/

local vars = require("configs/vars")
local mod  = vars.mainMod
local exec = hl.dsp.exec_cmd

local function key(k, ...)
    local parts = { ... }
    table.insert(parts, k)
    return table.concat(parts, " + ")
end

-- Apps and window actions
hl.bind(key("Q", mod),      hl.dsp.window.close())
hl.bind(key("RETURN", mod), exec(vars.terminal))
hl.bind(key("M", mod),      exec("hyprshutdown")) -- graceful logout
hl.bind(key("R", mod),      exec(vars.terminal .. " -e " .. vars.fileManager))
hl.bind(key("V", mod),      hl.dsp.window.float({ action = "toggle" }))
hl.bind(key("D", mod),      exec(vars.menu))
hl.bind(key("P", mod),      hl.dsp.layout("focusmaster")) -- master layout: focus the master window
hl.bind(key("J", mod),      hl.dsp.layout("cyclenext"))   -- master layout: focus the next window
hl.bind(key("B", mod),      exec(vars.browser))
hl.bind(key("ESCAPE", "CTRL"), exec("pkill waybar || waybar"))
hl.bind(key("ESCAPE", mod), exec("~/.config/rofi/scripts/powermenu.sh"))
hl.bind(key("L", mod),      exec("hyprlock"))
hl.bind(key("F", mod),      hl.dsp.window.fullscreen({ mode = "fullscreen" }))
-- hl.bind(key("P", mod), exec("~/.local/bin/walset.sh"))

hl.bind(key("TAB", mod),   hl.dsp.focus({ workspace = "previous" }))
hl.bind(key("SPACE", mod), hl.dsp.layout("swapwithmaster"))

-- Utilities
-- hl.bind(key("PRINT", mod),          exec("hyprshot -m output"))
-- hl.bind(key("PRINT", mod, "SHIFT"), exec("hyprshot -m region"))
-- hl.bind(key("C", mod, "SHIFT"),     exec("hyprpicker -a"))

-- Move focus with mod + arrow keys
hl.bind(key("left", mod),  hl.dsp.focus({ direction = "left" }))
hl.bind(key("right", mod), hl.dsp.focus({ direction = "right" }))
hl.bind(key("up", mod),    hl.dsp.focus({ direction = "up" }))
hl.bind(key("down", mod),  hl.dsp.focus({ direction = "down" }))

-- Workspaces 1-10 (key 0 = workspace 10)
--   mod + N          switch to workspace
--   mod + CTRL + N   move window there and follow it
--   mod + SHIFT + N  move window there silently
for i = 1, 10 do
    local n = tostring(i % 10)
    hl.bind(key(n, mod),          hl.dsp.focus({ workspace = i }))
    hl.bind(key(n, mod, "CTRL"),  hl.dsp.window.move({ workspace = i, follow = true }))
    hl.bind(key(n, mod, "SHIFT"), hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Special workspace (scratchpad)
hl.bind(key("S", mod),          hl.dsp.workspace.toggle_special("magic"))
hl.bind(key("S", mod, "SHIFT"), hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mod + scroll
hl.bind(key("mouse_down", mod), hl.dsp.focus({ workspace = "e+1" }))
hl.bind(key("mouse_up", mod),   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mod + LMB/RMB drag
hl.bind(key("mouse:272", mod), hl.dsp.window.drag(),   { mouse = true })
hl.bind(key("mouse:273", mod), hl.dsp.window.resize(), { mouse = true })

-- Volume and brightness keys (work on the lock screen, repeat when held)
local media = { locked = true, repeating = true }
hl.bind("XF86AudioRaiseVolume",  exec("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), media)
hl.bind("XF86AudioLowerVolume",  exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      media)
hl.bind("XF86AudioMute",         exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     media)
hl.bind("XF86AudioMicMute",      exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   media)
hl.bind("XF86MonBrightnessUp",   exec("brightnessctl set 5%+"),                          media)
hl.bind("XF86MonBrightnessDown", exec("brightnessctl set 5%-"),                          media)

-- Media player keys (requires playerctl)
hl.bind("XF86AudioNext",  exec("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", exec("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  exec("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  exec("playerctl previous"),   { locked = true })
