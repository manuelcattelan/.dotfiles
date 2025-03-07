#!/usr/bin/env bash

# Function to display script usage
echo_script_usage() {
    echo "Usage: $(basename $0) <mode>"
    echo "Connect/disconnect bluetooth headphone with specified mode."
    echo
    echo "mode:"
    echo "  on audio       Connects to headphones with better audio quality, headphones microphone unavailable."
    echo "  on microphone  Connects to headphones with lower audio quality, headphones microphone available."
    echo "  off            Disconnects from headphones."
    echo
    echo "Examples:"
    echo "  $(basename $0) on audio"
    echo "  $(basename $0) on microphone"
    echo "  $(basename $0) off"

    exit 1
}

# Bluetooth MAC address of headphones to connect to
headphones_mac="B8:81:FA:AF:06:0D"

# Connect or disconnect bluetooth headphones based on the provided mode
if [ $1 == "on" ]; then
    # Bluetooth input card, source, and profile of headphones to connect to
    headphones_input_card="bluez_card.B8_81_FA_AF_06_0D"

    # Set different input profile based on requirements
    if [ $2 == "audio" ]; then
        headphones_input_profile="a2dp_sink"
    elif [ $2 == "microphone" ]; then
        headphones_input_profile="handsfree_head_unit"
    else
        echo_script_usage
    fi

    # Power on bluetooth
    bluetoothctl power on

    # Trust and connect headphones via MAC address
    bluetoothctl trust $headphones_mac
    bluetoothctl connect $headphones_mac

    # Allow the changes to take effect
    sleep 1

    # Switch to the appropriate input profile and source
    pacmd set-card-profile $headphones_input_card $headphones_input_profile
elif [ $1 == "off" ]; then
    # Power off bluetooth
    bluetoothctl disconnect $headphones_mac
else
    echo_script_usage
fi
