
if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

# Start Hyprland when logging in on tty1
if status is-login; and test (tty) = /dev/tty1; and not pgrep -x Hyprland >/dev/null
    exec start-hyprland
end

source ~/.cache/wal/colors.fish

zoxide init fish | source
starship init fish | source 
fzf --fish | source
