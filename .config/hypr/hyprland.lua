-- Hyprland config (Lua, Hyprland 0.55+)
-- Ported from hyprland.conf; the original hyprlang config is in ~/.config/hypr.bak-hyprlang-2026-10-25
-- Docs: https://wiki.hypr.land/Configuring/Start/

local vars   = require("configs/vars")
local colors = vars.colors


----------------
--- MONITORS ---
----------------

-- https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1.25,
})


-----------------
--- AUTOSTART ---
-----------------

-- https://wiki.hypr.land/Configuring/Basics/Autostart/
-- hl.exec_cmd() is already async, so no trailing `&` is needed.
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")
    hl.exec_cmd("awww-daemon")
    -- hl.exec_cmd("gtk-launch notion")
end)


-----------------------------
--- ENVIRONMENT VARIABLES ---
-----------------------------

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


-------------------
--- PERMISSIONS ---
-------------------

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Permission changes need a Hyprland restart.
-- hl.config({ ecosystem = { enforce_permissions = true } })
-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


---------------------
--- LOOK AND FEEL ---
---------------------

-- https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 5,

        border_size = 2,

        col = {
            active_border   = colors.color4 or "rgba(33ccffee)",
            inactive_border = "rgba(595959aa)",
        },

        resize_on_border = true,

        -- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before turning this on
        allow_tearing = false,

        layout = "master",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = false,
    },

    -- https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
    dwindle = {
        -- pseudotile = true,
        preserve_split = true,
    },

    -- https://wiki.hypr.land/Configuring/Layouts/Master-Layout/
    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}  } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}  } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}     } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}  } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}   } })

-- All animations run at speed 1 (100ms), same as the old config.
local animations = {
    { "global",        "default" },
    { "border",        "easeOutQuint" },
    { "windows",       "easeOutQuint" },
    { "windowsIn",     "easeOutQuint", "popin 87%" },
    { "windowsOut",    "linear",       "popin 87%" },
    { "fadeIn",        "almostLinear" },
    { "fadeOut",       "almostLinear" },
    { "fade",          "quick" },
    { "layers",        "easeOutQuint" },
    { "layersIn",      "easeOutQuint", "fade" },
    { "layersOut",     "linear",       "fade" },
    { "fadeLayersIn",  "almostLinear" },
    { "fadeLayersOut", "almostLinear" },
    { "workspaces",    "almostLinear", "fade" },
    { "workspacesIn",  "almostLinear", "fade" },
    { "workspacesOut", "almostLinear", "fade" },
}
for _, a in ipairs(animations) do
    hl.animation({ leaf = a[1], enabled = true, speed = 1, bezier = a[2], style = a[3] })
end

-- "Smart gaps" / "No gaps when only" - uncomment to use.
-- https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 0, rounding = 0 })
-- hl.window_rule({ match = { float = false, workspace = "f[1]" },   border_size = 0, rounding = 0 })


-------------
--- INPUT ---
-------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        repeat_rate  = 50,
        repeat_delay = 150,

        follow_mouse = 1,

        sensitivity = 1.0, -- -1.0 to 1.0, 0 means no change

        touchpad = {
            natural_scroll = true,
        },
    },
})

-- Touchpad workspace swipe (replaces the old gestures { workspace_swipe }) - uncomment to use.
-- hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Per-device config example: https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
-- hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })


------------------------------------------
--- KEYBINDINGS, WINDOWS AND WORKSPACES ---
------------------------------------------

-- Each require() runs in its own scope, so an error in one file won't stop the others.
require("configs/binds")
require("configs/windowrules")
