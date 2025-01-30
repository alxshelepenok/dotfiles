#!/bin/bash

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ICON_PATH="${SCRIPT_DIR}/../icons/watts.svg"
readonly POWER_WATTS_CMD="${HOME}/.local/bin/powerwatts"

POWER_WATTS=$($POWER_WATTS_CMD 2>/dev/null)
if [ $? -ne 0 ]; then
    echo "Error: Failed to execute $POWER_WATTS_CMD" >&2
    exit 1
fi

readonly AC_ONLINE=$(cat /sys/class/power_supply/AC/online 2>/dev/null)
readonly BATTERY_WATTS=$(echo "$POWER_WATTS" | grep -oP '(?<=Battery: ).*' | head -n 1)
readonly CHARGING_WATTS=$(echo "$POWER_WATTS" | grep -oP '(?<=Charging: ).*' | head -n 1)

is_image() {
    file -b "$1" | grep -qE 'PNG|SVG'
}

if is_image "$ICON_PATH"; then
    INFO="<img>${ICON_PATH}</img>"
else
    INFO=""
fi

if [ "$AC_ONLINE" -eq 1 ]; then
    INFO+="<txt> ${CHARGING_WATTS}</txt>"
else
    INFO+="<txt> ${BATTERY_WATTS}</txt>"
fi

echo -e "${INFO}"

MORE_INFO="<tool>"
MORE_INFO+="┌ Power\n"
MORE_INFO+="├─ Charging\t\t${CHARGING_WATTS}\n"
MORE_INFO+="└─ Battery\t\t${BATTERY_WATTS}"
MORE_INFO+="</tool>"

echo -e "${MORE_INFO}"