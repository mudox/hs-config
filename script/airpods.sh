#!/user/bin/env bash

# Manages bluetooth connectivity of AirPods 

if [[ "$#" -ne 1 || ("$1" != "toggle" && "$1" != "status") ]]; then
  echo "Usage: airpods [toggle|status]"
  exit 1
fi

# `blueutil --paired` to show
NAME='NBN AirPods'
ID='38-ec-0d-58-93-7f' # MAC address

CMD='/opt/homebrew/bin/blueutil'

if ! "${CMD}" --info "${ID}" &>/dev/null; then 
  echo "AirPods mac address ${ID} is invalid"
fi

case $1 in
  toggle)
    if $CMD --is-connected "$ID" &>/dev/null; then
      echo "Connecting ${NAME}..."
      $CMD --connect "$ID" >/dev/null 2>&1 &
    else
      echo "Disconnecting ${NAME}..."
      $CMD --disconnect "$ID" >/dev/null 2>&1 &
    fi
    ;;

  status)
    if $CMD --is-connected "$ID" &>/dev/null; then
      echo "${NAME} Disconnected"
    else
      echo "${NAME} Connected"
    fi
    ;;
esac