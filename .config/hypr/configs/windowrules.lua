-- Window and layer rules. https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- Rules apply top to bottom; later matches win. All matches are RE2 regexes.

-- Ignore maximize requests from apps.
-- hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

-- Fix some dragging issues with XWayland
hl.window_rule({
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- Float file dialogs
-- hl.window_rule({
--     match  = { title = "^(Opens File|Open|Save|Save As|Import|Export|Choose File|Rename)$" },
--     float  = true,
--     center = true,
-- })

-- Inhibit idle while anything is fullscreen
-- hl.window_rule({ match = { fullscreen = true }, idle_inhibit = "fullscreen" })

-- Float some utility apps
-- hl.window_rule({ match = { class = "^(org.kde.polkit-kde-authentication-agent-1|nm-connection-editor|blueman-manager|pavucontrol|eog|gnome-system-monitor|yad)$" }, float = true })


---------------
--- OPACITY ---
---------------
-- "active inactive"

-- Rofi is styled by the layer rules at the bottom (it's a layer, not a window).
hl.window_rule({ match = { class = "^(com.mitchellh.ghostty)$" }, opacity = "0.9 0.8" })
hl.window_rule({ match = { class = "^(Spotify)$" },               opacity = "0.9 0.7" })
hl.window_rule({ match = { class = "^(steam)$" },                 opacity = "0.9 0.7" })
-- hl.window_rule({ match = { class = "^(yad)$" },  opacity = "0.9 0.7" })


-------------------------
--- PICTURE-IN-PICTURE ---
-------------------------

hl.window_rule({
    match   = { title = "^(Picture-in-Picture)$" },
    opacity = "0.95 0.75",
    float   = true,
    pin     = true,
    size    = { "monitor_w*0.25", "monitor_h*0.25" },
    move    = { "monitor_w*0.72", "monitor_h*0.07" },
})


------------------------
--- DESKTOP GREMLINS ---
------------------------

hl.window_rule({
    match       = { title = "ilgwg_desktop_gremlins.py" },
    no_blur     = true,
    no_shadow   = true,
    border_size = 0,
})


-------------------
--- LAYER RULES ---
-------------------

-- Rofi: dim background, pop-in animation, blur
hl.layer_rule({
    match        = { namespace = "rofi" },
    dim_around   = true,
    animation    = "popin 10%",
    blur         = true,
    ignore_alpha = 0,
    no_anim = true,
})

-- wlogout
hl.layer_rule({ match = { namespace = "logout_dialog" }, blur = true })

-- hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
-- hl.layer_rule({ match = { namespace = "^swaync-(control-center|notification-window)$" }, blur = true, ignore_alpha = 0.5 })
