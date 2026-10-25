#!/usr/bin/env bash

# Restart waybar fully detached so it does not die with the shell/terminal that ran this.
pkill -x waybar
setsid -f waybar >/dev/null 2>&1
