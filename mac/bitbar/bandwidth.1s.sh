#!/usr/bin/env bash

# <bitbar.title>Bandwidth</bitbar.title>
# <bitbar.version>v0.0.0</bitbar.version>
# <bitbar.author>Ant Cosentino</bitbar.author>
# <bitbar.author.github>skibz</bitbar.author.github>
# <bitbar.desc>Displays TX and RX bitrate of your main ethernet interface in the status bar and hides other interfaces in the context menu.</bitbar.desc>
# <bitbar.dependencies>ifstat</bitbar.dependencies>
# <bitbar.image>https://cloud.githubusercontent.com/assets/2462211/12748504/584bbcea-c9b3-11e5-8109-ad8fdcefdc75.png</bitbar.image>

export PATH="/usr/local/bin:${PATH}"
# INTERFACES=$(ifconfig -lu)
MAIN_INTERFACE="en0"

data=$(ifstat -z -S -q 1 1)
INTERFACES=$(echo -e "${data}" | head -n 1)

echo "▼ $(ifstat -n -w -i ${MAIN_INTERFACE} 0.1 1 | tail -n 1 | awk '{print $1, " - ", $2;}') ▲"
echo "---"
for INTERFACE in ${INTERFACES}; do
  if [[ ${INTERFACE} != "${MAIN_INTERFACE}" ]]; then
    echo "${INTERFACE}: ▼ $(ifstat -n -w -i "${INTERFACE}" 0.1 1 | tail -n 1 | awk '{print $1, " - ", $2;}') ▲"
  fi
done
