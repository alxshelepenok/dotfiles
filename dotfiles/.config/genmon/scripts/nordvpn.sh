#!/bin/bash
 
NORDVPN_STATUS="$(nordvpn status)"
CONNECTED=$(echo "$NORDVPN_STATUS" 2>/dev/null | grep -o -P '(?<=Status: ).*')
 
if [ "$CONNECTED" == "Connected" ]; then
  CURRENT_SERVER=$(echo "$NORDVPN_STATUS" | grep -o -P '(?<=Current server: ).*')
  CURRENT_CITY=$(echo "$NORDVPN_STATUS" | grep -o -P '(?<=City: ).*')
  INFO="<icon>network-vpn-symbolic</icon>"
  INFO+="<txt> ${CURRENT_CITY} / ${CURRENT_SERVER}</txt>"
  INFO+="<tool></tool>"
else
  INFO="<icon>network-vpn-symbolic</icon>"
  INFO+="<txt>${CONNECTED}</txt>"
  INFO+="<tool></tool>"
fi

echo -e "${INFO}"