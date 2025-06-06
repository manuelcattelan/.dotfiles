#!/usr/bin/env bash

# Function to display script usage
echo_script_usage() {
    echo "Usage: $(basename $0) <toggle>"
    echo "Toggle source volume mute."
    echo
    echo "toggle:"
    echo "  toggle (when unmuted)  Mute source volume"
    echo "  toggle (when muted)    Unmute source volume"
    echo
    echo "Examples:"
    echo "  $(basename $0) toggle"
    exit 1
}

# Toggle the source volume mute state
if [[ -n $1 ]] && [[ $1 == "toggle" ]]; then
    pactl set-source-mute @DEFAULT_SOURCE@ toggle
    if echo $(pactl get-source-mute @DEFAULT_SOURCE@) | grep -q "Mute: yes"; then
        source_volume_status="muted"
    else
        source_volume_status="unmuted"
    fi
    dunstify "Microphone tweaked!" "Microphone is now $source_volume_status." \
        -u low -h string:x-dunst-stack-tag:microphone
else
    echo_script_usage
fi
