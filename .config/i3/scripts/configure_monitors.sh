#!/usr/bin/env bash

# Function to configure connected monitors
configure_monitors() {
    # Get the list of connected monitors
    monitors_count=$(xrandr --query | grep " connected" | wc -l)

    if [ $monitors_count -eq 2 ]; then
        # Check if the external monitor is connected
        if xrandr --query | grep -q "DP-1 connected"; then
            xrandr --output eDP-1 --auto --output DP-1 --auto --right-of eDP-1
        fi
    else
        # Enable the laptop's monitor if no external monitors are connected
        eval xrandr --output eDP-1 --output DP-1 --off
    fi
}

# Set the correct configuration for all connected monitors
configure_monitors

# Function to monitor udev events and reconfigure monitors when changes occur
configure_udev() {
    udevadm monitor --subsystem-match=drm --udev | while read -r line; do
        if [[ $line == *"change"* ]] && [[ $line == *"drm"* ]]; then
            # Sleep for 1 second to allow the monitors' configuration to be updated
            sleep 1

            # Set the correct configuration for all connected monitors
            configure_monitors
            # Set the wallpaper on all connected monitors
            source $XDG_CONFIG_HOME/i3/scripts/configure_background.sh
        fi
    done
}

# Monitor udev events in the background
(configure_udev) &

# Detach the process from the script so that monitoring will continue running
# when the script exits.
disown $!
