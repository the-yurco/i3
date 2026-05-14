#!/bin/bash

# Dynamic monitor setup for i3wm
# Laptop: eDP | External: HDMI-1-0

INTERNAL="eDP"
EXTERNAL="HDMI-1-0"

# Check if external monitor is connected
if xrandr | grep "$EXTERNAL connected" > /dev/null; then
    # External monitor connected
    # Set external to the right of laptop, external as primary
    xrandr --output "$INTERNAL" --auto --rate 144 --output "$EXTERNAL" --mode 1920x1080 --primary --rate 144 --right-of "$INTERNAL"

    # Wait for xrandr to apply
    sleep 1

    # Workspaces 1-5 on external monitor (HDMI-1-0)
    for ws in 1 2 3 4 5; do
        i3-msg "workspace $ws, move workspace to output $EXTERNAL"
    done

    # Workspaces 6-10 on laptop (eDP)
    for ws in 6 7 8 9 10; do
        i3-msg "workspace $ws, move workspace to output $INTERNAL"
    done

    notify-send "Monitor Setup" "External monitor enabled\nWorkspaces 1-5: External\nWorkspaces 6-10: Laptop" -t 3000
else
    # No external monitor - all workspaces on laptop
    xrandr --output "$INTERNAL" --auto --primary --output "$EXTERNAL" --off

    notify-send "Monitor Setup" "Single monitor mode\nAll workspaces on laptop" -t 3000
fi

# Refresh wallpaper across all monitors
feh --bg-fill ~/Downloads/wallpaper.jpg
