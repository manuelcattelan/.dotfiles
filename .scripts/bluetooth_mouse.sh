#!/usr/bin/env bash

# Function to display script usage
echo_script_usage() {
    echo "Usage: $(basename $0) <mode>"
    echo "Connect/disconnect bluetooth mouse"
    echo
    echo "mode:"
    echo "  on   Connects to mouse."
    echo "  off  Disconnects from mouse."
    echo
    echo "Examples:"
    echo "  $(basename $0) on"
    echo "  $(basename $0) off"

    exit 1
}

# Bluetooth MAC address of mouse to connect to
mouse_mac="D1:D0:A1:CC:2D:C6"

# Connect or disconnect bluetooth mouse based on the provided argument
if [ $1 == "on" ]; then
    # Power on bluetooth
    bluetoothctl power on

    # Pair, trust and connect mouse via MAC address
    bluetoothctl pair $mouse_mac
    bluetoothctl trust $mouse_mac
    bluetoothctl connect $mouse_mac
elif [ $1 == "off" ]; then
    # Power off bluetooth
    bluetoothctl disconnect $mouse_mac
else
    echo_script_usage
fi
