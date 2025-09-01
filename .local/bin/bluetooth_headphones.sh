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
if [[ $1 == "on" ]]; then
    # Bluetooth headphones' input card, source, and profile
    headphones_input_card="bluez_card.B8_81_FA_AF_06_0D"
    # Set different input profile and corresponding sink/source based on requirements
    if [[ $2 == "audio" ]]; then
        # Set different input profile based on requirements
        headphones_input_profile="a2dp_sink"
        # Bluetooth headphones' audio sink and source
        headphones_source="bluez_sink.B8_81_FA_AF_06_0D.a2dp_sink.monitor"
        headphones_sink="bluez_sink.B8_81_FA_AF_06_0D.a2dp_sink"
    elif [[ $2 == "microphone" ]]; then
        # Set different input profile based on requirements
        headphones_input_profile="handsfree_head_unit"
        # Bluetooth headphones' audio sink and source
        headphones_source="bluez_source.B8_81_FA_AF_06_0D.handsfree_head_unit"
        headphones_sink="bluez_sink.B8_81_FA_AF_06_0D.handsfree_head_unit"
    else
        echo_script_usage
    fi
    # Power on bluetooth
    bluetoothctl power on
    # Connect to bluetooth headphones via MAC address
    bluetoothctl connect $headphones_mac
    # Allow changes to take effect
    sleep 3
    # Switch to the appropriate input profile and source
    pacmd set-card-profile $headphones_input_card $headphones_input_profile
    # Allow changes to take effect
    sleep 3
    # When bluetooth headphones are connected, move all audio streams to them
    pactl set-default-source $headphones_source
    pactl set-default-sink $headphones_sink
elif [ $1 == "off" ]; then
    # Laptop monitor's audio sink and source
    laptop_source="alsa_output.pci-0000_64_00.6.HiFi__Speaker__sink.monitor"
    laptop_sink="alsa_output.pci-0000_64_00.6.HiFi__Speaker__sink"
    # Power off bluetooth
    bluetoothctl disconnect $headphones_mac
    # When bluetooth headphones are disconnected, move all audio streams to laptop
    pactl set-default-source $laptop_source
    pactl set-default-sink $laptop_sink
else
    echo_script_usage
fi
