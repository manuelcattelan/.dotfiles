#!/usr/bin/env bash

# Function to display script usage
echo_script_usage() {
    echo "Usage: $(basename $0) <offset/toggle>"
    echo "Increase/decrease sink volume by a percentage offset N or toggle mute."
    echo
    echo "offset:"
    echo "  +N%  Increases sink volume by N% from current value, where N is any integer value."
    echo "  -N%  Decreases sink volume by N% from current value, where N is any integer value."
    echo
    echo "toggle:"
    echo "  toggle (when unmuted)  Mute sink volume"
    echo "  toggle (when muted)    Unmute sink volume"
    echo
    echo "Examples:"
    echo "  $(basename $0) +10%"
    echo "  $(basename $0) -10%"
    echo "  $(basename $0) toggle"
    exit 1
}

# Adjust the sink volume or toggle mute based on the provided argument
if [ -n $1 ] && ([ $1 == "toggle" ] || [[ $1 =~ ^[+-][0-9]+%$ ]]); then
    if [ $1 == "toggle" ]; then
        # Toggle the sink mute state
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        if echo $(pactl get-sink-mute @DEFAULT_SINK@) | grep -q "Mute: yes"; then
            sink_volume_status="muted"
        else
            sink_volume_status="unmuted"
        fi
        dunstify "Volume tweaked!" "Volume is now $sink_volume_status." \
            -u low -h string:x-dunst-stack-tag:volume
    else
        # Adjust the sink volume
        pactl set-sink-volume @DEFAULT_SINK@ $1
        sink_volume_value=$(pactl get-sink-volume @DEFAULT_SINK@ \
            | grep -oP '\d+(?=%)' | head -n 1)
        if echo $(pactl get-sink-mute @DEFAULT_SINK@) | grep -q "Mute: yes"; then
            sink_volume_status="muted"
        else
            sink_volume_status="unmuted"
        fi
        if [ $sink_volume_status == "muted" ] && [ $sink_volume_value -gt 0 ]; then
            # Unmute the sink if the volume is non-zero
            pactl set-sink-mute @DEFAULT_SINK@ false
            # We do not need to explicitly set the sink volume since by
            # toggling `mute` to false, pactl already sets it for us.
            # pactl set-sink-volume @DEFAULT_SINK@ $1
            dunstify "Volume tweaked!" "Volume is now unmuted at ~$sink_volume_value%." \
                -u low -h string:x-dunst-stack-tag:volume
        elif [ $sink_volume_value -eq 0 ]; then
            # Mute the sink if the volume is zero
            pactl set-sink-mute @DEFAULT_SINK@ true
            dunstify "Volume tweaked!" "Volume is now muted." \
                -u low -h string:x-dunst-stack-tag:volume
        else
            dunstify "Volume tweaked!" "Volume is now at ~$sink_volume_value%." \
                -u low -h string:x-dunst-stack-tag:volume
        fi
    fi
else
    echo_script_usage
fi
