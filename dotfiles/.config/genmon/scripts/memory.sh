#!/bin/bash

readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

readonly ICON="${DIR}/../icons/memory.svg"

readonly TOTAL=$(free -b | awk '/^[Mm]em/{$2 = $2 / 1073741824; printf "%.2f", $2}')
readonly USED=$(free -b | awk '/^[Mm]em/{$3 = $3 / 1073741824; printf "%.2f", $3}')
readonly FREE=$(free -b | awk '/^[Mm]em/{$4 = $4 / 1073741824; printf "%.2f", $4}')
readonly SHARED=$(free -b | awk '/^[Mm]em/{$5 = $5 / 1073741824; printf "%.2f", $5}')
readonly CACHED=$(free -b | awk '/^[Mm]em/{$6 = $6 / 1073741824; printf "%.2f", $6}')
readonly AVAILABLE=$(free -b | awk '/^[Mm]em/{$7 = $7 / 1073741824; printf "%.2f", $7}')

readonly SWP_TOTAL=$(free -b | awk '/^[Ss]wap/{$2 = $2 / 1073741824; printf "%.2f", $2}')
readonly SWP_USED=$(free -b | awk '/^[Ss]wap/{$3 = $3 / 1073741824; printf "%.2f", $3}')
readonly SWP_FREE=$(free -b | awk '/^[Ss]wap/{$4 = $4 / 1073741824; printf "%.2f", $4}')

if [[ $(file -b "${ICON}") =~ PNG|SVG ]]; then
  INFO="<img>${ICON}</img>"
  if hash xfce4-taskmanager &> /dev/null; then
    INFO+="<click>xfce4-taskmanager</click>"
  fi
  INFO+="<txt>"
else
  INFO="<txt>"
fi
INFO+=" ${USED}"
INFO+=" - "
INFO+="${TOTAL} GB"
INFO+="</txt>"

echo -e "${INFO}"

MORE_INFO="<tool>"
MORE_INFO+="┌ RAM\n"
MORE_INFO+="├─ Used\t\t${USED} GB\n"
MORE_INFO+="├─ Free\t\t${FREE} GB\n"
MORE_INFO+="├─ Shared\t${SHARED} GB\n"
MORE_INFO+="├─ Cache\t${CACHED} GB\n"
MORE_INFO+="└─ Total\t\t${TOTAL} GB"
MORE_INFO+="\n\n"
MORE_INFO+="┌ SWAP\n"
MORE_INFO+="├─ Used\t\t${SWP_USED} GB\n"
MORE_INFO+="├─ Free\t\t${SWP_FREE} GB\n"
MORE_INFO+="└─ Total\t\t${SWP_TOTAL} GB"
MORE_INFO+="</tool>"

echo -e "${MORE_INFO}"