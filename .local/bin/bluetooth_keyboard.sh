#!/usr/bin/env bash

# Function to display script usage
echo_script_usage() {
    echo "Usage: $(basename $0) <mode>"
    echo "Connect/disconnect bluetooth keyboard"
    echo
    echo "mode:"
    echo "  on   Connects to keyboard."
    echo "  off  Disconnects from keyboard."
    echo
    echo "Examples:"
    echo "  $(basename $0) on"
    echo "  $(basename $0) off"
    exit 1
}

# Bluetooth MAC address of keyboard to connect to
keyboard_mac="6C:93:08:60:CB:42"
# Connect or disconnect bluetooth keyboard based on the provided argument
if [ $1 == "on" ]; then
    # Power on bluetooth
    bluetoothctl power on
    # Connect to keyboard via MAC address
    bluetoothctl connect $keyboard_mac
elif [ $1 == "off" ]; then
    # Power off bluetooth
    bluetoothctl disconnect $keyboard_mac
else
    echo_script_usage
fi
