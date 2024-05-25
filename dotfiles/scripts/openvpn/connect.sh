#!/bin/bash

current_dir=$(dirname "$0")

source $current_dir/.env

if [[ "$1" == "--help" ]]; then
    echo "Usage: $0 [OPTION] [ARGUMENT]"
    echo "Connect to NordVPN using OpenVPN."
    echo ""
    echo "Options:"
    echo "  --help          Display this help message."
    echo "  --list          List available configuration files."
    echo "  --config        Connect to NordVPN using the specified configuration file."
    echo ""
    echo "Arguments:"
    echo "  --list          [COUNTRY] List available configuration files for the specified country."
    echo "  --config        [FILE] Connect to NordVPN using the specified configuration file."
    exit 0
fi

if [[ "$1" == "--list" ]]; then
    country_name="$2"
    if [[ -z $country_name ]]; then
        echo "Available configuration files:"
        for file in $current_dir/configs/*.ovpn; {
            echo "$(basename "$file")"
        }
    else
        echo "Available configuration files for country '$country_name':"
        for file in $current_dir/configs/"$country_name"*.ovpn; {
            echo "$(basename "$file")"
        }
    fi
    exit 0
fi

if [[ "$1" == "--config" ]]; then
    if [[ -z "$2" ]]; then
        echo "Error: Missing configuration file."
        exit 1
    fi

    ovpn_file="$current_dir/configs/$2"

    if [ ! -f $ovpn_file ]; then
        echo "Error: OVPN file '$ovpn_file' not found."
        exit 1
    fi

    sudo su -c 'openvpn \
    --config "'$ovpn_file'" \
    --auth-user-pass <(echo "'$USERNAME'"; echo "'$PASSWORD'")'

    if [[ $? -eq 0 ]]; then
        echo "Connected to NordVPN successfully."
    else
        echo "Error: Failed to connect to NordVPN."
    fi

    exit 0
fi
